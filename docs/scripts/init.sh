sudo apt-get update -y && sudo apt-get upgrade -y 
sudo apt install build-essential git -y

mkdir -p temp && cd temp
wget https://go.dev/dl/go1.19.3.linux-amd64.tar.gz
sudo tar -xvf go1.19.3.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo mv go /usr/local/
rm ~/temp/go1.19.3.linux-amd64.tar.gz
cd

# Setup golang environment variables
#vi ~/.bash_aliases
echo 'export GOROOT=/usr/local/go' > ~/.bash_aliases
echo 'export GOPATH=$HOME/go' >> ~/.bash_aliases
echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> ~/.bash_aliases
source ~/.bash_aliases


# clone
cd
git clone https://github.com/Fantom-foundation/go-opera.git
cd go-opera/
git checkout release/1.1.3-rc.5
# use the below if you run a trace node
#git checkout release/txtracing/1.1.3-rc.5
make