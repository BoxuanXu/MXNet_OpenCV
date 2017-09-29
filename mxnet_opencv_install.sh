#!/bin/bash
#__website__     = "www.seetatech.com"
#__author__      = "seetatech"
#__editor__      = "xuboxuan"
#__Date__        = "20170914"

echo "please enter your password:"
read PASSWORD

s_pwd=$PWD

#openblas install
if [ ! -s "/usr/local/openblas/lib/libopenblas.so" ];then
   echo "begin install openblas..."
   echo PASSWORD | sudo mkdir /usr/local/openblas
   
   if [ -d "OpenBLAS" ];then
      cd OpenBLAS
       
      make PREFIX=/usr/local/openblas
      echo PASSWORD | sudo make install PREFIX=/usr/local/openblas
	
      echo PASSWORD | sudo ln -s /usr/local/openblas/lib/libopenblas.so /usr/lib64/libopenblas.so
      if [ -s "/etc/profile.d/openblas.sh" ];then
         echo PASSWORD | sudo rm -rf /etc/profile.d/openblas.sh    
      fi	

      echo PASSWORD | sudo sh -c "echo \#\!/bin/sh >> /etc/profile.d/openblas.sh"
      echo PASSWORD | sudo sh -c "echo export OPENBLAS_HOME=/usr/local/openblas >> /etc/profile.d/openblas.sh"
      echo PASSWORD | sudo sh -c "echo export OPENBLAS_INC=\"$\"OPENBLAS_HOME/include >> /etc/profile.d/openblas.sh"
      echo PASSWORD | sudo sh -c "echo export C_INCLUDE_PATH=\"$\"C_INCLUDE_PATH:\"$\"OPENBLAS_INC >> /etc/profile.d/openblas.sh"
      echo PASSWORD | sudo sh -c "echo export CPLUS_INCLUDE_PATH=\"$\"CPLUS_INCLUDE_PATH:\"$\"OPENBLAS_INC >> /etc/profile.d/openblas.sh"

      source /etc/profile
  
      if [ -s "/etc/ld.so.conf.d/openblas.conf" ];then
         echo PASSWORD | sudo rm -rf /etc/ld.so.conf.d/openblas.conf   
      fi

      echo PASSWORD | sudo sh -c "echo /usr/local/openblas/lib >> /etc/ld.so.conf.d/openblas.conf"
      echo PASSWORD | sudo ldconfig
   else
      echo "Don't find OpenBLAS-0.2.19.zip"
      exit 1;
   fi
else
   echo "openblas has been installed"
fi

cd $s_pwd

if [ -s "/usr/local/openblas/lib/libopenblas.so" ];then
   echo "openblas install success"
else   
   echo "openblas install failed"
   exit 1
fi


#cmake install
if ! command -v cmake;then
   echo "begin install cmake..."
   echo PASSWORD | sudo mkdir /usr/local/cmake
   if [ -s "cmake-3.8.0.tar.gz" ];then
      tar -xvf cmake-3.8.0.tar.gz
      cd cmake-3.8.0
      ./bootstrap --prefix=/usr/local/cmake
      make
      echo PASSWORD | sudo make install
      
      if [ -s "/etc/profile.d/cmake.sh" ];then
         echo PASSWORD | sudo rm -rf /etc/profile.d/cmake.sh
      fi

      echo PASSWORD | sudo sh -c "echo \#\!/bin/sh >> /etc/profile.d/cmake.sh"
      echo PASSWORD | sudo sh -c "echo export CMAKE_HOME=/usr/local/cmake >> /etc/profile.d/cmake.sh"
      echo PASSWORD | sudo sh -c "echo export PATH=\"$\"CMAKE_HOME/bin:\"$\"PATH >> /etc/profile.d/cmake.sh"

      source /etc/profile
   else
      echo "Don't find cmake-3.8.0.tar.gz"
      exit 1;
   fi
else
   echo "cmake has been installed"
fi

cd $s_pwd

if ! command -v cmake;then
   echo "cmake install failed"
   exit 1
else   
   echo "cmake install success"
fi
#opencv install

if ! command -v opencv_version;then
   echo "begin install opencv..."
   echo PASSWORD | sudo mkdir /usr/local/opencv-2.4.13.2
   if [ -s "opencv-2.4.13.2.zip" ];then
      unzip opencv-2.4.13.2.zip
      cd opencv-2.4.13.2
      cmake -D CMAKE_INSTALL_PREFIX=/usr/local/opencv-2.4.13.2 .
      make
      echo PASSWORD | sudo make install

      if [ -s "/etc/profile.d/opencv.sh" ];then
         echo PASSWORD | sudo rm -rf /etc/profile.d/opencv.sh   
      fi
      echo PASSWORD | sudo sh -c "echo \#\!/bin/sh >> /etc/profile.d/opencv.sh"
      echo PASSWORD | sudo sh -c "echo export OPENCV_HOME=/usr/local/opencv-2.4.13.2 >> /etc/profile.d/opencv.sh"
      echo PASSWORD | sudo sh -c "echo export OPENCV_INC=\"$\"OPENCV_HOME/include >> /etc/profile.d/opencv.sh"
      echo PASSWORD | sudo sh -c "echo export OPENCV_LIB=\"$\"OPENCV_HOME/lib >> /etc/profile.d/opencv.sh"
      echo PASSWORD | sudo sh -c "echo export OPENCV_BIN=\"$\"OPENCV_HOME/bin >> /etc/profile.d/opencv.sh"
      echo PASSWORD | sudo sh -c "echo export PATH=\"$\"PATH:\"$\"OPENCV_BIN >> /etc/profile.d/opencv.sh"
      echo PASSWORD | sudo sh -c "echo export C_INCLUDE_PATH=\"$\"C_INCLUDE_PATH:\"$\"OPENCV_INC >> /etc/profile.d/opencv.sh"
      echo PASSWORD | sudo sh -c "echo export CPLUS_INCLUDE_PATH=\"$\"CPLUS_INCLUDE_PATH:\"$\"OPENCV_INC >> /etc/profile.d/opencv.sh"

      source /etc/profile

      if [ -s "/etc/ld.so.conf.d/opencv.conf" ];then
         echo PASSWORD | sudo rm -rf /etc/ld.so.conf.d/opencv.conf
      fi
      echo PASSWORD | sudo sh -c "echo /usr/local/opencv-2.4.13.2/lib >> /etc/ld.so.conf.d/opencv.conf"

      echo PASSWORD | sudo ldconfig

      if [ -s "/usr/local/lib/pkgconfig/opencv.pc" ];then
         echo PASSWORD | sudo rm -rf /usr/local/lib/pkgconfig/opencv.pc
      fi
      echo PASSWORD | sudo sh -c "echo prefix=/usr/local/opencv-2.4.13.2 >> /usr/local/lib/pkgconfig/opencv.pc"
      echo PASSWORD | sudo sh -c "echo exec_prefix=\"$\"{prefix}/bin >> /usr/local/lib/pkgconfig/opencv.pc"
      echo PASSWORD | sudo sh -c "echo includedir=\"$\"{prefix}/include >> /usr/local/lib/pkgconfig/opencv.pc"
      echo PASSWORD | sudo sh -c "echo libdir=\"$\"{prefix}/lib >> /usr/local/lib/pkgconfig/opencv.pc"
      echo PASSWORD | sudo sh -c "echo  >> /usr/local/lib/pkgconfig/opencv.pc"
      echo PASSWORD | sudo sh -c "echo Name: opencv>> /usr/local/lib/pkgconfig/opencv.pc"
      echo PASSWORD | sudo sh -c "echo Description: The opencv library>> /usr/local/lib/pkgconfig/opencv.pc"
      echo PASSWORD | sudo sh -c "echo Version: 2.4.13.2 >> /usr/local/lib/pkgconfig/opencv.pc"
      echo PASSWORD | sudo sh -c "echo Cflags: -I\"$\"{includedir}/opencv -I\"$\"{includedir}/opencv2 >> /usr/local/lib/pkgconfig/opencv.pc"
      echo PASSWORD | sudo sh -c "echo Libs: -L\"$\"{libdir} -lopencv_core -lopencv_imgproc -lopencv_highgui -lopencv_ml -lopencv_video -lopencv_features2d -lopencv_calib3d -lopencv_objdetect -lopencv_contrib -lopencv_legacy -lopencv_flann >> /usr/local/lib/pkgconfig/opencv.pc"
   
   else
      echo "Don't find opencv-2.4.13.2.zip"
      exit 1;
   fi
else
   echo "opencv has been installed"
fi

cd $s_pwd

if ! command -v opencv_version;then
   echo "opencv install failed"
   exit 1
else   
   echo "opencv install success"
fi

#mxnet install
echo "begin install mxnet..."
if [ -d "mxnet" ];then
   cd mxnet
   cp make/config.mk .

   if [ -d "/usr/local/cuda" ];then
      sed -i "s/USE_CUDA = 0/USE_CUDA = 1/g" config.mk
      sed -i "s/USE_CUDA_PATH = NONE/USE_CUDA_PATH = /usr/local/cuda/g" config.mk
   
      if [ ! -s "/etc/ld.so.conf.d/cuda.conf" ];then
         echo PASSWORD | sudo sh -c "echo /usr/local/cuda/lib64 >> /etc/ld.so.conf.d/cuda.conf"
         echo PASSWORD | sudo ldconfig        
      fi
   fi

   sed -i '95a USE_BLAS = openblas' config.mk
   sed -i '97a USE_BLAS_PATH = /usr/local/openblas/' config.mk

   make -j4
   
   cd $s_pwd
   
   python -c "import graphviz";
   if [ $? == 0 ];then
      echo "grphviz has been installed";
   else 
      unzip graphviz-0.8.zip
      cd graphviz-0.8
      echo PASSWORD | sudo python setup.py build 
      echo PASSWORD | sudo python setup.py install   
   fi

   cd $s_pwd
   
   python -c "import requests";
   if [ $? == 0 ];then
      echo "requests has been installed";
   else 
      tar -xvf requests-2.7.0.tar.gz
      cd requests-2.7.0
      echo PASSWORD | sudo python setup.py build 
      echo PASSWORD | sudo python setup.py install   
   fi
 
   cd $s_pwd
   
   python -c "import numpy";
   if [ $? == 0 ];then
      echo "numpy has been installed";
   else 
      unzip numpy-1.13.1.zip
      cd numpy-1.13.1
      echo PASSWORD | sudo python setup.py build 
      echo PASSWORD | sudo python setup.py install   
   fi
  
   cd $s_pwd
   python -c "import mxnet";
   if [ $? == 0 ];then
      echo "mxnet python api has been installed";
   else 
      cd mxnet/python

      echo PASSWORD | sudo python setup.py install
   
      echo "mxnet python api install finish"
   fi
  
else
   echo "Don't find mxnet dir..."
fi

cd $s_pwd

