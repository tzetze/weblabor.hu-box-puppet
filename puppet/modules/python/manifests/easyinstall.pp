define python::easyinstall($ensure = "present") {
    case $ensure {
        "present": {
            exec { "/usr/bin/easy_install $name":
                unless  => "/bin/ls -la /usr/local/lib/python2.7/dist-packages/ | grep $name"
            }
        }
    }
}