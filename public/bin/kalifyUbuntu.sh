#!/bin/bash
# ===================================================
# Originally a CPTC script used to turn cloud Ubuntu
# images into roughly "Kali" Linux hosts.
# ---------------------------------------------------
# Credits: Lucas Morris @ https://nationalcptc.org
# ---------------------------------------------------
# modified for mass public use by:
# - removing CPTC-specific devops functions
# - removing "CPTC" from the sources.list comment
# - removing the PS1 configuration
# ===================================================

mkdir /tmp/installer
cd /tmp/installer || exit 1
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb >msfinstall
chmod 755 msfinstall
./msfinstall
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
apt-key adv --keyserver pgp.mit.edu --recv-keys ED444FF07D8D0BF6
apt-key adv --keyserver pgp.mit.edu --recv-keys ED444FF07D8D0BF6

echo '# Kali linux repositories for Kalified Cloud Ubuntu' >>/etc/apt/sources.list
echo 'deb http://http.kali.org/kali kali-rolling main contrib non-free' >>/etc/apt/sources.list

apt-key adv --keyserver pgp.mit.edu --recv-keys ED444FF07D8D0BF6
apt-get update && apt-get upgrade
apt-get -qq -f -y install --no-install-recommends nmap </dev/null
apt-get -f -y install --no-install-recommends \
 	acccheck \
 	amap \
 	apache-users \
 	automater \
 	backdoor-factory \
 	bbqsql \
 	bed \
	beef-xss \
 	blindelephant \
 	braa \
 	bulk-extractor \
 	cewl \
 	chntpw \
 	cowpatty \
 	crackle \
 	creddump \
 	crunch \
 	cryptcat \
 	cymothoa \
 	davtest \
 	dbd \
 	dc3dd \
 	ddrescue \
 	deblaze \
 	dex2jar \
 	dirb \
 	dmitry \
 	dnmap \
 	dns2tcp \
 	dnschef \
 	dnsenum \
 	dnsmap \
 	dnsrecon \
 	dnstracer \
 	dnswalk \
 	doona \
 	dos2unix \
 	dotdotpwn \
 	dradis \
 	enum4linux \
 	exploitdb \
 	fierce \
 	fimap \
 	findmyhash \
 	firewalk \
 	foremost \
 	fragroute \
 	fragrouter \
 	funkload \
 	galleta \
 	golismero \
 	goofile \
 	gpp-decrypt \
 	grabber \
 	hamster-sidejack \
 	hash-identifier \
 	hexinject \
 	hping3 \
 	httptunnel \
 	iaxflood \
 	intersect \
 	intrace \
 	ismtp \
 	jad \
 	jboss-autopwn \
 	jd \
 	john \
 	joomscan \
 	keimpx \
 	lbd \
 	linux-exploit-suggester \
 	lynis \
 	maskprocessor \
 	masscan \
 	metagoofil \
 	mitmproxy \
 	ncrack \
 	nipper-ng \
 	nishang \
 	nmap \
 	oclgausscrack \
 	ollydbg \
 	default-jdk-headless \
 	default-jre-headless \
 	openvas-cli \
 	openvas-manager \
 	openvas-scanner \
 	p0f \
 	pack \
 	parsero \
 	pdf-parser \
 	pdfid \
 	pdgmail \
 	peepdf \
 	pipal \
 	plecost \
 	polenum \
 	powersploit \
 	rainbowcrack \
 	rcracki-mt \
 	rebind \
 	recon-ng \
 	responder \
 	ridenum \
 	rsmangler \
 	sbd \
 	sfuzz \
 	shellnoob \
 	skipfish \
 	slowhttptest \
 	smtp-user-enum \
 	sniffjoke \
 	snmpcheck \
 	sqlmap \
 	sqlninja \
 	sqlsus \
 	sslcaudit \
 	sslsplit \
 	sslstrip \
 	sslyze \
 	statsprocessor \
 	theharvester \
 	tlssled \
 	twofi \
 	ua-tester \
 	uniscan \
 	unix-privesc-check \
 	urlcrazy \
 	volatility \
 	webshells \
 	websploit \
 	weevely \
 	wfuzz \
 	wordlists \
 	wpscan \
 	xplico \
 	xspy \
 	yara \
 	yersinia

wget http://www.morningstarsecurity.com/downloads/bing-ip2hosts-0.4.tar.gz
tar -xzvf bing-ip2hosts-0.4.tar.gz
cp bing-ip2hosts-0.4/bing-ip2hosts /usr/local/bin/

cat <<'EOF' >>/etc/profile.d/Z1_PS1.sh
# ------------------------------------------------------------------------------
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
# ------------------------------------------------------------------------------
NO_COLOUR="\[\033[0m\]"
RED="\[\033[00;31m\]"
GREEN="\[\033[00;32m\]"
YELLOW="\[\033[00;33m\]"
BLUE="\[\033[00;34m\]"
MAGENTA="\[\033[00;35m\]"
PURPLE="\[\033[00;35m\]"
CYAN="\[\033[00;36m\]"
LIGHTGRAY="\[\033[00;37m\]"
LRED="\[\033[01;31m\]"
LGREEN="\[\033[01;32m\]"
LYELLOW="\[\033[01;33m\]"
LBLUE="\[\033[01;34m\]"
LMAGENTA="\[\033[01;35m\]"
LPURPLE="\[\033[01;35m\]"
LCYAN="\[\033[01;36m\]"
WHITE="\[\033[01;37m\]"
EOF

chmod +x /etc/profile.d/Z1_PS1.sh
echo "" >>~/.bashrc
echo "source /etc/profile.d/Z1_PS1.sh" >>~/.bashrc
echo "" >>/etc/skel/.bashrc
echo "source /etc/profile.d/Z1_PS1.sh" >>/etc/skel/.bashrc
