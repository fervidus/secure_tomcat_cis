require 'spec_helper'

describe 'secure_tomcat' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge(
            staging_http_get: 'curl',
            augeasversion: '1.7.0'
          )
        end

        let(:params) {
          {
            installs: {
              '/opt/tomcat' => {
                'user'       => 'tomcat_admin',
                'group'      => 'tomcat',
                'source_url' => 'https://www-us.apache.org/dist/tomcat/tomcat-7/v7.0.73/bin/apache-tomcat-7.0.73.tar.gz',
              }
            },
            wars: {
              'hello.war' => {
                'catalina_base' => '/opt/tomcat',
                'war_source' => 'https://glassfish.dev.java.net/downloads/quickstart/hello.war',
              }
            }
          }
        }

        context "secure_tomcat class with an install and war" do
          it { is_expected.to compile.with_all_deps }
        end
      end
    end
  end

  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge(
            staging_http_get: 'curl',
            augeasversion: '1.7.0'
          )
        end

        let(:params) {
          {
            installs: {
              '/opt/tomcat8' => {
                'user'       => 'tomcat_admin',
                'group'      => 'tomcat',
                'source_url' => 'https://www.apache.org/dist/tomcat/tomcat-8/v8.0.x/bin/apache-tomcat-8.0.x.tar.gz',
              },
              '/opt/tomcat6' => {
                'user'       => 'tomcat_admin',
                'group'      => 'tomcat',
                'source_url' => 'http://www-eu.apache.org/dist/tomcat/tomcat-6/v6.0.x/bin/apache-tomcat-6.0.x.tar.gz',
              }
            },
            instances: {
              'tomcat8-first' => {
                'catalina_home' => '/opt/tomcat8',
                'catalina_base' => '/opt/tomcat8/first',
              },
              'tomcat8-second' => {
                'catalina_home' => '/opt/tomcat8',
                'catalina_base' => '/opt/tomcat8/second',
              },
              'tomcat6' => {
                'catalina_home' => '/opt/tomcat6',
              },
            },
            # Change the default port of the second instance server and HTTP connector
            config_servers: {
              'tomcat8-second' => {
                'catalina_base' => '/opt/tomcat8/second',
                'port'          => '8006',
              },
              # Change tomcat 6's server and HTTP/AJP connectors
              'tomcat6' => {
                'catalina_base' => '/opt/tomcat6',
                'port'          => '8105',
              },
            },
            config_server_connectors: {
              'tomcat8-second-http' => {
                'catalina_base'         => '/opt/tomcat8/second',
                'port'                  => '8081',
                'protocol'              => 'HTTP/1.1',
                'additional_attributes' => {
                  'redirectPort' => '8443',
                },
              },
              'tomcat6-http' => {
                'catalina_base'         => '/opt/tomcat6',
                'port'                  => '8180',
                'protocol'              => 'HTTP/1.1',
                'additional_attributes' => {
                  'redirectPort' => '8543',
                },
              },
              'tomcat6-ajp' => {
                'catalina_base'         => '/opt/tomcat6',
                'port'                  => '8109',
                'protocol'              => 'AJP/1.3',
                'additional_attributes' => {
                  'redirectPort' => '8543',
                },
              },
            },
          }
        }

        context "secure_tomcat class with an lots of install and no wars" do
          it { is_expected.to compile.with_all_deps }
        end
      end
    end
  end

  # context 'unsupported operating system' do
  #   describe 'secure_tomcat class without any parameters on Solaris/Nexenta' do
  #     let(:facts) do
  #       {
  #         osfamily: 'Solaris',
  #         operatingsystem: 'Nexenta',
  #       }
  #     end

  #     it { expect { is_expected.to contain_package('secure_tomcat') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
  #   end
  # end
end