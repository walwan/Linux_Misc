#!/bin/bash

# Program configuration
AURPkgDir="${HOME}/WW/Software/AUR/" # AUR built package sync dir
numPkgKeep=3 # Number of versions of package to keep

# Environment variable
yayAURCache="${HOME}/.cache/yay/"
readonly yayAURCache

# program name and command string constant
scriptName="aurpkgmgr.sh"
readonly scriptName

cmdSyncPkg="syncpkg"
readonly cmdSyncPkg

cmdCleanPkg="cleanpkg"
readonly cmdCleanPkg

cmdChkDynPkgVer="chkdynpkgver"
readonly cmdChkDynPkgVer

cmdList=(   ${cmdSyncPkg}
            ${cmdCleanPkg}
            ${cmdChkDynPkgVer})
readonly cmdList

_processArg(){
    # Process arguments
    if test $# -eq 0; then
        _showHelp
    else
        if test ${1} = ${cmdSyncPkg}; then
            _syncPkg
        elif test ${1} = ${cmdCleanPkg}; then
            _cleanPkg
        elif test ${1} = ${cmdChkDynPkgVer}; then
            _chkDynPkgVer
        else
            _showHelp
        fi
    fi
}

_askYesOrNo(){
    # Default answer is no
    default=0
    defPrompt=" [y/N]"
    if test $# -gt 0; then
        case "${1}" in
            "y" | "Y" | "yes" | "Yes" | "YES")
            default=1
            defPrompt=" [Y/n]"
            ;;
        esac
    fi

    read -p "${defPrompt}" input

    if test -n "${input}"; then
        case "${input}" in
            "y" | "Y" | "yes" | "Yes" | "YES")
            result=1
            ;;
            "n" | "N" | "no" | "No" | "NO")
            result=0
            ;;
            *)
            printf "Unexpected input! Please retry!"
            _askYesOrNo
            result=$?
            ;;
        esac
    else
        result=${default}
    fi

    return ${result}
}

_showHelp(){
    printf "Usage: %s " ${scriptName}

    cmdCnt=0
    printf "<"
    for cmd in ${cmdList[@]}; do
        printf "%s" ${cmd}
        ((cmdCnt++))
        if test ${cmdCnt} -lt ${#cmdList[@]}; then
            printf "/"
        fi
    done
    printf "> [options]\n"
}

_syncPkg(){
    for folder in `ls ${yayAURCache}`; do
        if test -d "${yayAURCache}/${folder}"; then
            for file in `ls ${yayAURCache}/${folder}/*.pkg.tar.zst 2> /dev/null`; do
                if test -n ${file}; then
                    if test ! -d "${AURPkgDir}/${folder}"; then
                        mkdir -p "${AURPkgDir}/${folder}"
                    fi

                    printf "Moving ${file} to ${AURPkgDir}/${folder}/\n"

                    newFilePath="${AURPkgDir}/${folder}/`basename ${file}`"
                    #echo ${newFilePath}
                    if test -e ${newFilePath}; then
                        printf "The target file :\"%s\" already exists, overwride?" ${newFilePath}
                        _askYesOrNo
                        if test $? -eq 0; then
                            continue
                        fi
                    fi
                    mv ${file} "${AURPkgDir}/${folder}"
                fi
            done
        fi
    done
}

_cleanOldPkg(){
    # Initialize variable
    numPkgClean=0
    pkgCleanPath=()

    for folder in `ls ${AURPkgDir}`; do
        if test -d "${AURPkgDir}/${folder}"; then
            pkgCount=()
            SubPkgName=()

            for file in `ls -t ${AURPkgDir}/${folder}`; do
                # Check valid package
                ChkOutput=`echo ${file} | grep ".pkg.tar"`
                if test -z ${ChkOutput}; then
                    continue
                fi

                # Parsing package name
                PkgName=`LC_ALL=en pacman -Qp ${AURPkgDir}/${folder}/${file} | sed "s/[[:space:]].*$//g"`
                SubPkgIndex=0
                if test ${#SubPkgName[@]} -eq 0; then
                    SubPkgName[${SubPkgIndex}]=${PkgName}
                    pkgCount[${SubPkgIndex}]=1
                else
                    for name in ${SubPkgName[${SubPkgIndex}]}; do
                        if test ${name} = ${PkgName}; then
                            ((pkgCount[${SubPkgIndex}]++))
                            break
                        fi
                        ((SubPkgIndex++))
                    done
                    if test $SubPkgIndex -eq ${#SubPkgName[@]}; then
                        SubPkgName[${SubPkgIndex}]=${PkgName}
                        pkgCount[${SubPkgIndex}]=1
                    fi
                fi

                # Check package count
                if test ${pkgCount[${SubPkgIndex}]} -gt ${numPkgKeep}; then
                    pkgCleanPath[${numPkgClean}]="${AURPkgDir}/${folder}/${file}"
                    ((numPkgClean++))
                fi
            done
        fi
    done

    # Output results
    printf "%d package(s) to be cleaned:\n" ${numPkgClean}
    if test ${numPkgClean} -gt 0; then
        OutputCnt=1
        for file in ${pkgCleanPath[@]}; do
            printf "%d: %s\n" ${OutputCnt} ${file}
            ((OutputCnt++))
        done

        printf "Start Cleaning?"
        _askYesOrNo
        if test $? -eq 1; then
            for file in ${pkgCleanPath[@]}; do
                rm -r ${file}
            done
            printf "Done Cleaning!\n"
        fi
    fi
}

_cleanUninstalledPkg(){
    # Initialize variable
    numPkgClean=0
    pkgCleanPath=()

    for folder in `ls ${AURPkgDir}`; do
        if test -d "${AURPkgDir}/${folder}"; then

            for file in `ls -t ${AURPkgDir}/${folder}`; do
                # Check valid package
                ChkOutput=`echo ${file} | grep ".pkg.tar"`
                if test -z ${ChkOutput}; then
                    continue
                fi

                # Parsing package name
                PkgName=`LC_ALL=en pacman -Qp ${AURPkgDir}/${folder}/${file} | sed "s/[[:space:]].*$//g"`
                InstalledPkgName=`LC_ALL=en pacman -Q ${PkgName} 2>&1 | sed "s/[[:space:]].*$//g"`

                if test "${InstalledPkgName}" != "${PkgName}"; then
                    pkgCleanPath[${numPkgClean}]="${AURPkgDir}/${folder}/${file}"
                    ((numPkgClean++))
                fi

            done
        fi
    done

    # Output results
    printf "%d package(s) to be cleaned:\n" ${numPkgClean}
    if test ${numPkgClean} -gt 0; then
        OutputCnt=1
        for file in ${pkgCleanPath[@]}; do
            printf "%d: %s\n" ${OutputCnt} ${file}
            ((OutputCnt++))
        done

        printf "Start Cleaning?"
        _askYesOrNo
        if test $? -eq 1; then
            for file in ${pkgCleanPath[@]}; do
                rm -r ${file}
            done
            printf "Done Cleaning!\n"
        fi
    fi
}

_cleanPkg(){
    printf "Clean uninstalled packages?"
    _askYesOrNo
    if test $? -eq 1; then
        _cleanUninstalledPkg
    fi

    printf "Clean old packages?"
    _askYesOrNo
    if test $? -eq 1; then
        _cleanOldPkg
    fi
}

_chkDynPkgVer(){
    # Initialize variable
    numDynVerPkg=0
    dynVerPkgName=()

    for PKGBUILDFile in `ls ${yayAURCache}/*/PKGBUILD 2> /dev/null`; do
        tempStr=`cat ${PKGBUILDFile} | grep "pkgver()"`

        if test -n "${tempStr}"; then
            dynVerPkgName[${numDynVerPkg}]=`echo ${PKGBUILDFile} | sed "s/\/PKGBUILD//g" | sed "s/^.*\/\///g"`
            ((numDynVerPkg++))
        fi
    done

    # Output results
    printf "%d package(s) has dynamic versioning:\n" ${numDynVerPkg}
    if test ${numDynVerPkg} -gt 0; then
        pkgCnt=1

        for pkgName in ${dynVerPkgName[@]}; do
            printf "%d: %s\n" ${pkgCnt} "${pkgName}"
            ((pkgCnt++))
        done
    fi
}

_processArg "$@"