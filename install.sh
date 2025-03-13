###Parallel-META installer
###Updated by Xiaoquan Su at July 3, 2024. Added compilation related to PM-profiler
###Bioinformatics Group, College of Computer Science and Technology, Qingdao University
###Code by: Yuzhu Chen, Xiaoquan Su, Honglei Wang, Gongchao Jing
#!/bin/bash
##Users can change the default environment variables configuration file here
Ver="3.7.3"
if [[ $SHELL = '/bin/zsh' ]];
then
        PATH_File=~/.zshrc
        if [ ! -f "$PATH_File" ]
        then
                PATH_File=~/.zsh_profile
                if [ ! -f "$PATH_File" ]
                then
                        touch $PATH_File
                fi
        fi
else
        PATH_File=~/.bashrc
        if [ ! -f "$PATH_File" ]
        then
                PATH_File=~/.bash_profile
                if [ ! -f "$PATH_File" ]
                then
                        touch $PATH_File
                fi
        fi

fi
PM_PATH=`pwd`
Sys_ver=`uname`
###Checking that environment variable of Parallel-META exists###
Check_old_pm=`grep "export ParallelMETA"  $PATH_File|awk -F '=' '{print $1}'`
Check_old_path=`grep "ParallelMETA/bin"  $PATH_File |sed 's/\(.\).*/\1/' |awk '{if($1!="#"){print "Ture";}}'`
Check_old_Rscript_path=`grep "ParallelMETA/Rscript"  $PATH_File |sed 's/\(.\).*/\1/' |awk '{if($1!="#"){print "Ture";}}'`
Add_Part="####DisabledbyParallelMetaSuite####"
echo "**Parallel-Meta Suite Installation**"
echo "**version " $Ver "**"

###Build source code for src package###
if [ -f "Makefile" ]
   then
       echo -e "\n**Parallel-Meta Suite src package**"
       make
       echo -e "\n**Build Complete**"
else
   echo -e "\n**Parallel-Meta Suite bin package**"
fi
chmod +x $PM_PATH/bin/vsearch
chmod +x $PM_PATH/bin/hmmsearch
###Build source code for PM-profiler###
cd PM-profiler
if [ -f "Makefile" ]
   then
       echo -e "\n**PM-profiler src package**"
       make
       echo -e "\n**Build Complete**"
else
   echo -e "\n**PM-profiler bin package**"
fi
cd ..
###Configure environment variables###
if [ "$Check_old_pm" != "" ]
   then
      Checking=`grep ^export\ ParallelMETA  $PATH_File|awk -F '=' '{print $2}'`
      if [ "$Checking" != "$PM_PATH" ]
         then
         if [ "$Sys_ver" = "Darwin" ]
            then
            # First remove all existing ParallelMETA export lines to avoid duplication
            sed -i "" "/^export ParallelMETA/d" $PATH_File
            # Then add the new export line at the end of the file
            echo "export ParallelMETA=$PM_PATH" >> $PATH_File
         else
            # First remove all existing ParallelMETA export lines to avoid duplication
            sed -i "/^export ParallelMETA/d" $PATH_File
            # Then add the new export line at the end of the file
            echo "export ParallelMETA=$PM_PATH" >> $PATH_File
         fi
     fi    
elif [ "$Check_old_pm" = "" ]
    then
      echo "export ParallelMETA="${PM_PATH} >> $PATH_File
fi

# Check and remove any duplicate PATH entries
if [ "$Check_old_path" != "" ]
    then
      if [ "$Sys_ver" = "Darwin" ]
         then
         sed -i "" "/^export PATH=\$PATH:\$ParallelMETA\/bin/d" $PATH_File
      else
         sed -i "/^export PATH=\$PATH:\$ParallelMETA\/bin/d" $PATH_File
      fi
fi

# Add PATH entry
echo "export PATH=\$PATH:\$ParallelMETA/bin" >> $PATH_File

# Check and remove any duplicate Rscript PATH entries
if [ "$Check_old_Rscript_path" != "" ]
    then
      if [ "$Sys_ver" = "Darwin" ]
         then
         sed -i "" "/^export PATH=\$PATH:\$ParallelMETA\/Rscript/d" $PATH_File
      else
         sed -i "/^export PATH=\$PATH:\$ParallelMETA\/Rscript/d" $PATH_File
      fi
fi

# Add Rscript PATH entry
echo "export PATH=\$PATH:\$ParallelMETA/Rscript" >> $PATH_File

###Source the environment variable file###
source $PATH_File
echo -e "\n**Environment Variables Configuration Complete**"

###Configurate the R packages###
echo -e ""
# First run renv_setup.R to create the renv environment
Rscript $PM_PATH/Rscript/renv_setup.R
# Then run config.R to check if all packages are installed
Rscript $PM_PATH/Rscript/config.R
chmod +x $PM_PATH/Rscript/PM_*.R

###End
echo -e "\n**Parallel-Meta Suite Installation Complete**"
echo -e "\n**An example dataset with demo script is available in \"example\"**"


