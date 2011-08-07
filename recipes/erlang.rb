# Installs the correct version of erlang from source for the current release of riak-search

[
    'build-essential',
    'libncurses5-dev',
    'openssl',
    'libssl-dev'
].each do |pkg|
    package pkg do
        action :install
    end
end

remote_file "/usr/src/otp_src_R13B04.tar.gz" do
    source "http://erlang.org/download/otp_src_R13B04.tar.gz"
    mode "0644"
    checksum "e2694383b3857f5edfc242b8c3acbfba4683e448387fa124d8e587cba234af43"
end

bash "install_erlang" do
    user "root"
    cwd "/usr/src"
    code <<-EOH
    tar -xzf otp_src_R13B04.tar.gz
    cd otp_src_R13B04
    ./configure && make && sudo make install
    EOH
    not_if "which erl"
end
