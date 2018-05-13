#!/usr/bin/env bash

set -e

scripts_dir='/opt/nifi-registry/scripts'

[ -f "${scripts_dir}/common.sh" ] && . "${scripts_dir}/common.sh"


prop_rm () {
  target_file=${3:-${nifi_registry_props_file}}
  sed -i -e "s|^$1=.*$||" ${target_file}
}

prop_add () {
  target_file=${3:-${nifi_registry_props_file}}
  echo 'replacing target file ' ${target_file}
  echo "$1=$2" >> ${target_file}
}


for varname in $(export | grep -- USER_NIFI_ | cut -d= -f 1 | cut -d" " -f 3); do
  echo ${varnmae}
  varvalue=${!varname}
  propname=$(echo $varname | sed -e 's/.*USER_NIFI_//' | tr _ .)

  prop_rm "${propname}"
  prop_add "${propname}" "${varvalue}"
done


# vim: expandtab:ts=2:sw=2
