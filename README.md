# bxcleanup
Scripts associated with automating the shutdown of inactive Cloud Foundry apps in Bluemix

**Usage**
1) Install bx cli
2) Create API key
3) Add names of apps to be excluded from the shutdown process to the whitelist_apps file
4)  ./bxsuspend.sh <cert_file> <TRUE or FALSE> | grep whitelist
  
  *only use TRUE when you want to actually shutdown the apps.. FALSE is like a preview*

