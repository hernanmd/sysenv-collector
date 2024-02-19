#!/bin/bash
# Copyright 2024 Hernán Morales Durand. All Rights Reserved.
#

set -u  # Check for undefined variables
# set -o noclobber  # Avoid overlay files (echo "hi" > foo)
# set -o errexit    # Used to exit upon error, avoiding cascading errors
# set -o pipefail   # Unveils hidden failures
set -o nounset    # Exposes unset variables

# Returns 0 if command was found in the current system, 1 otherwise
cmd_exists () {
	type "$1" &> /dev/null || [ -f "$1" ];
	return $?
}

printf "Collecting system information...\n"

output_file=env.txt
rm -f "$output_file" 

{
#  printf '\n'
#  printf '== are we in docker =============================================\n'
#  num=$(cat /proc/1/cgroup | grep docker | wc -l);
#  if [ $num -ge 1 ]; then
#    echo "Yes"
#  else
#    echo "No"
#  fi

  printf '\n'
  printf '== uname =====================================================\n'
  uname -a 2>&1

  printf '\n'
  printf '== shell =====================================================\n'
  "$SHELL" --version 2>&1

  printf '\n'
  printf '== git =====================================================\n'
  cmd_exists git && git --version 2>&1

  printf '\n'
  printf '== wget =====================================================\n'
  cmd_exists wget && wget --version 2>&1

  printf '\n'
  printf '== curl =====================================================\n'
  cmd_exists curl && curl --version 2>&1

  printf '\n'
  printf '== zip =====================================================\n'
  cmd_exists zip && zip --version 2>&1

  printf '\n'
  printf '== unzip =====================================================\n'
  cmd_exists unzip && unzip --version 2>&1

  printf '\n'
  printf '== tar =====================================================\n'
  cmd_exists tar && tar --version 2>&1

  printf '\n'
  printf '== grep =====================================================\n'
  cmd_exists grep && grep --version 2>&1

  printf '\n'
  printf '== ggrep =====================================================\n'
  cmd_exists ggrep && ggrep --version 2>&1

  printf '\n'
  printf '== openssl =====================================================\n'
  cmd_exists openssl && openssl version 2>&1    

  printf '\n'
  printf '== jq =====================================================\n'
  cmd_exists jq && jq --version 2>&1  

  printf '\n'
  printf '== xcode-select =====================================================\n'
  cmd_exists xcode-select && xcode-select --version 2>&1

  printf '\n'
  printf '== /usr/bin/xcodebuild =======================================\n'
  cmd_exists /usr/bin/xcodebuild && /usr/bin/xcodebuild -version 2>&1 

  printf '\n'
  printf '== clang =====================================================\n'
  cmd_exists clang && clang --version 2>&1

  printf '\n'
  printf '== CLT SDKs ==================================================\n'
  cmd_exists ls && ls /Library/Developer/CommandLineTools/SDKs/ 2>&1

  printf '\n'
  printf '== cmake =====================================================\n'
  cmd_exists cmake && cmake --version 2>&1

  printf '\n'
  printf '== make =====================================================\n'
  cmd_exists make && make --version 2>&1

  printf '\n'
  printf '== ninja =====================================================\n'
  cmd_exists ninja && ninja --version 2>&1  

  printf '\n'
  printf '== llvm-config =====================================================\n'
  cmd_exists llvm-config && llvm-config --version 2>&1  

  printf '\n'
  printf '== llvm-config cflags ===============================================\n'
  cmd_exists llvm-config && llvm-config --cflags 2>&1  

  printf '\n'
  printf '== llvm-config cxxflags ===============================================\n'
  cmd_exists llvm-config && llvm-config --cxxflags 2>&1  

  printf '\n'
  printf '== llvm-config ldflags =============================================\n'
  cmd_exists llvm-config && llvm-config --ldflags 2>&1  

  printf '\n'
  printf '== llvm-config libs =================================================\n'
  cmd_exists llvm-config && llvm-config --libs 2>&1

  printf '\n'
  printf '== llvm-config system-libs ============================================\n'
  cmd_exists llvm-config && llvm-config --system-libs 2>&1

  printf '\n'
  printf '== llvm-config components ============================================\n'
  cmd_exists llvm-config && llvm-config --components 2>&1

  printf '\n'
  printf '== llvm-config bindir ============================================\n'
  cmd_exists llvm-config && llvm-config --bindir 2>&1

  printf '\n'
  printf '== llvm-config libdir ============================================\n'
  cmd_exists llvm-config && llvm-config --libdir 2>&1

  printf '\n'
  printf '== llvm-config includedir ============================================\n'
  cmd_exists llvm-config && llvm-config --includedir 2>&1

  printf '\n'
  printf '== python =====================================================\n'
  cmd_exists python && python --version 2>&1  

  printf '\n'
  printf '== pip =====================================================\n'
  cmd_exists pip && pip --version 2>&1

  printf '\n'
  printf '== conda =====================================================\n'
  cmd_exists conda && conda --version 2>&1 

  printf '\n'
  printf '== pyenv =====================================================\n'
  cmd_exists pyenv && pyenv versions 2>&1

  printf '\n'
  printf '== java =====================================================\n'
  cmd_exists java && java --version 2>&1 

  printf '\n'
  printf '== R =====================================================\n'
  cmd_exists R && R --version 2>&1 

  printf '\n'
  printf '== Rust =====================================================\n'
  cmd_exists rustc && rustc --version 2>&1 

  printf '\n'
  printf '== go =====================================================\n'
  cmd_exists go && go --version 2>&1 

  printf '\n'
  printf '== node =====================================================\n'
  cmd_exists node && node --version 2>&1 

  printf '\n'
  printf '== npm =====================================================\n'
  cmd_exists npm && npm --version 2>&1

  printf '\n'
  printf '== npx =====================================================\n'
  cmd_exists npx && npx --version 2>&1

  printf '\n'
  printf '== ruby =====================================================\n'
  cmd_exists ruby && ruby --version 2>&1

  printf '\n'
  printf '== swift =====================================================\n'
  cmd_exists swift && swift --version 2>&1

  printf '\n'
  printf '== bats =====================================================\n'
  cmd_exists bats && bats --version 2>&1

  printf '\n'
  printf '== brew =====================================================\n'
  cmd_exists brew && brew developer 2>&1

  printf '\n'
  printf '== brew =====================================================\n'
  cmd_exists brew && brew ruby -e 'puts MacOS::Xcode.version' 2>&1

  printf '\n'
  printf '== env ==========================================================\n'
  sysOS=$(uname -s)
  if [[ "$sysOS" == "Darwin" ]]; then
    if [ -z ${DYLD_LIBRARY_PATH+x} ]; then
      printf "DYLD_LIBRARY_PATH is unset\n";
    else
      printf "MacOS DYLD_LIBRARY_PATH=%s\n" "$DYLD_LIBRARY_PATH"
    fi
  elif [ "$sysOS" == "Linux" ]; then
    if [ -z ${LD_LIBRARY_PATH+x} ]; then
      printf "LD_LIBRARY_PATH is unset\n"
    else
      printf "Linux LD_LIBRARY_PATH=%s\n" "$LD_LIBRARY_PATH"
    fi
  fi
  } >> ${output_file}

printf "Wrote environment to %s You can review the contents of that file.\n" ${output_file}
printf "and use it to populate the fields in the github issue template.\n"
printf '\n'
printf "cat %s | less\n" ${output_file}
printf '\n'
