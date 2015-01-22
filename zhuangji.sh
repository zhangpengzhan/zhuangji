#!/bin/bash
#本脚本用于 装机后 java eclipse adk ant ndk flash 环境变量配置 ~~~~~~
#author zhangpengzhan  mail  644606228@qq.com
base_path=$"/usr/opt"
root_path=$(dirname $(readlink -f $0))
cd $root_path;

#cd $base_path

#sudo -i

read -p "if you want input new path:" NAME

if [ ! "$NAME"x == ""x ]

then
base_path=$NAME
printf $"\n i cat do that\n"

else

printf $"\n ok i do that\n"
#exit

fi

ls
#echo password
#mkdir if the path is exit

#sudo mkdir $base_path

if [ ! -d "$base_path" ]  
then

sudo mkdir -p $base_path

printf  "\n"$wenjiancunzai"\n"

fi

sudo chmod -R 777 $base_path"/"

# unzip all app and mv the app

function ergodic(){
  for file in `ls $1`
  do
      local path=$1"/"$file
      local name=$file
      local size=`du --max-depth=1 $path|awk '{print $1}'`
      local lastname=${file##*.};
      echo  "\n"$name "===" $size "====" $path "======"  $lastname"\n"
   if [ -d $1"/"$file ]
  then
       
    printf "\n i can't in next path======"$1"/"$file"\n"
    printf "\n $root_path\n"
    printf "\n $base_path\n"
#      ergodic $1"/"$file
if [  ! "$root_path"  ==  $"base_path"  ]
then
#	echo "$name" |grep -q "jdk"
#	if [ $? -eq 0 ]
	if [[ "$name" =~ "jdk" ]]
	then
	printf "yes jdk\n"
	java1=$"${base_path}"/"$name"
	java2=$"${java1}/bin"
	java3=$"CLASSPATH=.:${java1}/lib:${java1}/lib/tools.jar"

	
	fi

	if [[ "$name" =~ "ant" ]]
	    then
	    printf "\n yes ant \n"
	    ant1=$"${base_path}"/"$name""/bin"
	
	fi

	if [[ "$name" =~ "gradle" ]]
		then
		printf "\n yes gradle"
		gradle1=$"${base_path}"/"$name""/bin"
	fi	
	
	if [[ "$name" =~ "ndk" ]]
	then
	printf "\n yes ndk\n"
	ndk1=$"${base_path}"/"$name"
	fi
	
	if [[ "$name" =~ "adt" ]]
	then
	printf "\n yes adt\n"
	eclipse1=$"${base_path}/$name/eclipse"
	adb1=$"${base_path}"/"$name"/"sdk/platform-tools"
	adb2=$"${base_path}"/"$name"/"sdk/tools"
	fi
	
#	if [[ "$name" =~ "flash" ]]
#	then
#	printf " \n yes flash\n"
	if [ -f  "$base_path/libflashplayer.so"  ] 
	then
	sudo mv $base_path"/"libflashplayer.so "/usr/lib/mozilla/plugins/"
	mv -r $base_path"/"usr/*    /usr/
	printf "\n cp====flashplayer\n"
	else
	printf "\n flashplayer failed\n"
	fi
#	fi
fi
    else
    

      if [ $lastname == "zip" ]
	then
	printf "\n nuzip:::"$path"\n"
	sudo unzip $path -d $base_path
	fi
       if [ $lastname == "gz" ]
	then
	printf "\n tar gz:::"$path"\n"

	sudo tar -zxvf  $path  -C  $base_path

	fi
	if [ $lastname == "bz2" ] 
	then 
	printf "\n tar bz2:::"$path"\n"
	sudo tar -jxvf $path -C $base_path
	fi
	sudo chmod -R 777 $base_path


 
   fi
  done
}

IFS=$'\n'                      #这个必须要，否则会在文件名中有空格时出错
INIT_PATH=".";

ergodic $INIT_PATH

cd $base_path
root_path=$(dirname $(readlink -f $0))
printf "\n move==path:::$root_path\n"

ergodic $INIT_PATH


# set the app path

cd ~/


all_path=$"PATH=${gradle1}":"${ant1}":"${java2}":"${ndk1}":"${eclipse1}":"${adb1}":"${adb2}":"$PATH"
echo -e "\n\n\n\n""export ADB=$adb1""\n""export ANDROID_HOME=$adb2""\n""export ANT=$ant1""\n""export GRADLE_HOME=$gradle1""\n""export JAVA_HOME=$java1""\n""export JAVA_BIN=$java2""\n""export $java3""\n""export NDK=$ndk1""\n""export ECLIPSE=$eclipse1""\n""export $all_path" >> ./.bashrc

source ./.bashrc
source ./.bashrc

#zheng jia 32 wei yi lai ku an zhuang

sudo apt-get install libc6-i386

sudo  apt-get update

sudo apt-get install lib32stdc++6 

sudo apt-get install lib32z1 lib32z1-dev


java -version
printf "\n\n\n\n\n"
ant -version
printf "\n\n\n\n\n"
adb -version
printf "\n\n\n\n\n"
ndk-build  -verson
printf "\n\n\n\n\n"




printf "\nall done::\n"

