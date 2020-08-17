#!/bin/bash

path=/var/lib/jenkins/workspace/Raghu
password=$(cat $path/cred** | grep sf | cut -d "=" -f 2)
hpassword=$(cat $path/cred** | grep hsf | cut -d "=" -f 2)



# ssh host key

mkdir -p ~/.ssh  &&  echo "Host *" > ~/.ssh/config && echo " StrictHostKeyChecking no" >> ~/.ssh/config
echo "# Allow Jenkins" >> /etc/sudoers && echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers


# Derpfest

sshpass -p $password rsync -avP -e ssh DerpFest**Dragon**.zip raghuvarma331@frs.sourceforge.net:/home/frs/project/drg-sprout/DerpFest
sshpass -p $password rsync -avP -e ssh DerpFest**Onyx**.zip   raghuvarma331@frs.sourceforge.net:/home/frs/project/b2n-sprout/DerpFest
sshpass -p $password rsync -avP -e ssh DerpFest**Plate2**.zip raghuvarma331@frs.sourceforge.net:/home/frs/project/pl2-sprout/DerpFest
sshpass -p $password rsync -avP -e ssh DerpFest**Crystal**.zip raghuvarma331@frs.sourceforge.net:/home/frs/project/ctl-sprout/DerpFest

# Evolution-X

sshpass -p $password rsync -avP -e ssh EvolutionX**Dragon**.zip  raghuvarma331@frs.sourceforge.net:/home/frs/project/drg-sprout/EvolutionX
sshpass -p $password rsync -avP -e ssh EvolutionX**Crystal**.zip raghuvarma331@frs.sourceforge.net:/home/frs/project/ctl-sprout/EvolutionX
sshpass -p $password rsync -avP -e ssh EvolutionX**Plate2**.zip  raghuvarma331@frs.sourceforge.net:/home/frs/project/pl2-sprout/EvolutionX

# Havoc-OS

sshpass -p $hpassword rsync -avP -e ssh Havoc-OS**Dragon**.zip  maintainers@frs.sourceforge.net:/home/frs/project/havoc-os/Dragon
sshpass -p $hpassword rsync -avP -e ssh Havoc-OS**Onyx**.zip  maintainers@frs.sourceforge.net:/home/frs/project/havoc-os/Onyx
sshpass -p $hpassword rsync -avP -e ssh Havoc-OS**Plate2**.zip  maintainers@frs.sourceforge.net:/home/frs/project/havoc-os/Plate2
sshpass -p $hpassword rsync -avP -e ssh Havoc-OS**Crystal**.zip  maintainers@frs.sourceforge.net:/home/frs/project/havoc-os/Crystal

# LineageOS

sshpass -p $password rsync -avP -e ssh lineage-17.1**Dragon**.zip  raghuvarma331@frs.sourceforge.net:/home/frs/project/drg-sprout/LineageOS
sshpass -p $password rsync -avP -e ssh lineage-17.1**Onyx**.zip    raghuvarma331@frs.sourceforge.net:/home/frs/project/b2n-sprout/LineageOS
sshpass -p $password rsync -avP -e ssh lineage-17.1**Crystal**.zip raghuvarma331@frs.sourceforge.net:/home/frs/project/ctl-sprout/LineageOS

# Pixel Experience

sshpass -p $password rsync -avP -e ssh PixelExperience**Dragon**.zip   raghuvarma331@frs.sourceforge.net:/home/frs/project/drg-sprout/PixelExperience
sshpass -p $password rsync -avP -e ssh PixelExperience**Onyx**.zip     raghuvarma331@frs.sourceforge.net:/home/frs/project/b2n-sprout/PixelExperience
sshpass -p $password rsync -avP -e ssh PixelExperience**Plate2**.zip   raghuvarma331@frs.sourceforge.net:/home/frs/project/pl2-sprout/PixelExperience
sshpass -p $password rsync -avP -e ssh PixelExperience**Crystal**.zip  raghuvarma331@frs.sourceforge.net:/home/frs/project/ctl-sprout/PixelExperience

# Resurrection-Remix

sshpass -p $password rsync -avP -e ssh RR**Dragon**.zip raghuvarma331@frs.sourceforge.net:/home/frs/project/drg-sprout/Resurrection-Remix
sshpass -p $password rsync -avP -e ssh RR**Onyx**.zip   raghuvarma331@frs.sourceforge.net:/home/frs/project/b2n-sprout/Resurrection-Remix
sshpass -p $password rsync -avP -e ssh RR**Plate2**.zip  raghuvarma331@frs.sourceforge.net:/home/frs/project/pl2-sprout/Resurrection-Remix
