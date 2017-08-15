#!/bin/sh
##############################################################################
# This script is designed to offer basic support to control costs when running
# a paid Bluemix account
#
# Required utilities: Bluemix command line
#
# Required parameters:  <API key file> <Shutdown Apps?>
#
# Shutdown App Options:
#     TRUE  -  Will stop any app not on the whitelist
#     FALSE -  Will identify, but not stop apps
#
# Get the API key using the following command:
# bx iam api-key-create <key_name> -d "scripting API key" -f <file>
#
# Contact: eanderso@us.ibm.com
##############################################################################


bx login -apikey $1;
echo `date`;

regions=`bx regions | grep https | awk '{print $1}'`

for h in $regions
  {

  #echo "Targeting Region: "$h".";
  bx target -r $h;

  orgs=`bx iam orgs | grep active | awk '{print $1}'`;

  #To Display all the Orgs use: echo $orgs

  #Loop through all of the orgs
  for i in $orgs
    {


      echo "Targeting org: "$i".";
      bx target -o $i;

      spaces=`bx iam spaces | tail -n +6`;

      for j in $spaces
        {
            echo "Getting running apps in space: "$j".";
            bx target -s $j;

            #Get the list of all the active apps
            apps=`bx app list | grep started | awk '{print $1}'`

            #Check for apps in the whitelist_apps
            for k in $apps
              {
                if grep -Fxq $k whitelist_apps
                then
                    echo $h":"$i":"$j":"$k" is in the whitelist."
                else
                    echo $h":"$i":"$j":"$k" is NOT in the whitelist."

                    if $2
                    then
                      {
                        echo "Stopping "$k"."
                        bx app stop $k
                      }
                    fi

                fi
              }


        #End of Spaces Loop
        }



    #End of Orgs Loop
    }

#End of Region Loop
}
