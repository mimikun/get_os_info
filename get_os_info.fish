function get_os_info --description 'Get OS infomation'

  function __help_message
    echo "Usage: get_os_info [-ah] "

    echo "         -a --all      Update all"
    echo "         -h --help     Print this help"
  end

  set -l options 'a/all' 'h/help'
  argparse -n get_os_info $options -- $argv
  or return 1

  if set -lq _flag_help
    __help_message
    return
  end

  function _get_os_bit
    echo (uname -m)
  end

  function _get_os_distribution
    if test -e /etc/os-release
      #echo "This distro is Linux"
      if test -e /etc/arch-release
        #echo "This distro is arch base"
        set base_dist "arch"
          if test -e /etc/lsb-release
            #echo "Endeavour OS"
            set dist_name "endeavouros"
          else
            #echo "Arch Linux"
            set dist_name "arch"
          end
      else if test -e /etc/redhat-release
        #echo "This distro is redhat base"
        set base_dist "redhat"
        if test -e /etc/fedora-release
          #echo "Fedora"
          set dist_name "fedora"
        else if test -e /etc/centos-release
          #echo "CentOS"
          set dist_name "centos"
        else
          #echo "unknown distro"
          set dist_name "unknown"
        end
      else if test -e /etc/debian_version
        #echo "This distro is debian base"
        set base_dist "debian"
        if test -e /etc/lsb-release
          #echo "Ubuntu"
          set dist_name "ubuntu"
        else
          #echo "Debian"
          set dist_name "debian"
        end
      else
        #echo "unknown distro"
        set dist_name "unknown"
      end
    else
      #echo "This distro is NOT Linux"
      if test (uname -s) = "Darwin"
        set dist_name "macOS"
      else
        # Other
        #echo "unkown distribution"
        set dist_name "unknown"
      end
    end

    echo $dist_name
  end

  if set -lq _flag_all
    _get_os_bit
  end
  _get_os_distribution
end
