# This is the template of `myconfig.sh`, and the later
# will be included in every script.

# You must set TINA_DIR for r16 tina dirctory.
# It is the ONLY line you have to modify in the whole compiling process. 
TINA_DIR=/home/projects/r16/tinav2.5

#
# The URL prefix of remote repository.

# Use this if you want to visit GitHub via HTTPS
REPO_URL=https://gitlab.fmsoft.cn/VincentWei

# Use this one if you can visit GitHub via SSH
# REPO_URL=git@github.com:VincentWei

# Use this one if you are a developer of MiniGUI
# REPO_URL=git4os@gitlab.fmsoft.cn:VincentWei

#
# The branch name; MiniGUI 4.0.x are located in rel-4-0 branch
BRANCH_NAME=rel-4-0

#
# Global configuration options
#GOPTS="--enable-develmode"
GOPTS=

#
# The runtime mode of MiniGUI; can be ths, procs, or sa.
RUNMODE=ths

#
# extra options for configuring MiniGUI core.
# MGOPTS="--with-targetname=external"
MGOPTS=

#
# The jobs number for building source.
NRJOBS=`getconf _NPROCESSORS_ONLN`

