def unindent(s)
  s.gsub(/^#{s.scan(/^[ \t]+(?=\S)/).min}/, '')
end

Vagrant.configure("2") do |config|
  config.vm.box = "archlinux/archlinux"
  config.vm.box_check_update = false

  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = "1024"
    vb.customize ["modifyvm", :id, "--vram", "128"]
  end

  config.vm.provision "config-pacman", type: "shell", inline: unindent(<<-SHELL)
    cat > /etc/pacman.d/mirrorlist <<EOF
    Server = https://mirrors.sjtug.sjtu.edu.cn/archlinux/\\$repo/os/\\$arch
    EOF
  SHELL

  config.vm.provision "sync", type: "shell", inline: <<-SHELL
    pacman -Syy --noconfirm
    pacman -Syu --noconfirm
  SHELL

  config.vm.provision "install-depends", type: "shell", inline: unindent(<<-SHELL)
    pacman -S gnome-shell lightdm lightdm-gtk-greeter --noconfirm --needed
    systemctl enable lightdm
    groupadd -r autologin
    usermod -aG autologin vagrant
    cat > /etc/lightdm/lightdm.conf <<EOF
    [LightDM]
    run-directory=/run/lightdm
    sessions-directory=/usr/share/wayland-sessions

    [Seat:*]
    session-wrapper=/etc/lightdm/Xsession
    autologin-user=vagrant
    autologin-session=gnome
    EOF
  SHELL

  config.vm.provision "restart-dm", type: "shell", inline: <<-SHELL
    systemctl restart lightdm
  SHELL
end
