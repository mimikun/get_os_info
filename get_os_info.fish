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
    if test -e /etc/debian_version -o /etc/debian_release
      if test -e /etc/lsb-release
        set dist_name "ubuntu"
      else
        set dist_name "debian"
      end
    else if test -e /etc/fedora-release
      set dist_name "fedora"
    else if test -e /etc/redhat-release
      if test -e /etc/oracle-release
        # Oracle Linux
        set dist_name "oracle"
      else
        # RHEL
        set dist_name "redhat"
      end
    else if test -e /etc/arch-release
      set dist_name "arch"
    else if test -e /etc/turbolinux-release
      # Turbolinux
      set dist_name "turbol"
    else if test -e /etc/SuSE-release
      # SuSE Linux
      set dist_name "suse"
    else if test -e /etc/mandriva-release
      # Mandriva Linux
      set dist_name "mandriva"
    else if test -e /etc/vine-release
      # Vine Linux
      set dist_name "vine"
    else if test -e /etc/gentoo-release
      # Gentoo Linux
      set dist_name "gentoo"
    else
      # Other
      echo "unkown distribution"
      set dist_name "unkown"
    end

    echo $dist_name
  end

  if set -lq _flag_all
    _get_os_bit
  end
  _get_os_distribution
end

# debug:
#     sudo ln -sfnv (pwd)/get_os_info.fish $HOME/.config/fish/functions/get_os_info.fish
