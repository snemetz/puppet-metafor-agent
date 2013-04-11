# = Class: metafor
#
# Install agent and dependcies
#
class metafor inherits metafor::params {
  # Standard user account: metafor-agent
  # Create and manage account
  $metafor_password = hiera('metafor_password', $metafor_password)
  $metafor_guid = hiera('metafor_guid', $metafor_guid)
  include sunjdk
  include yum::repo::local_metafor
  package { $packages:
    ensure => installed,
  } ->
  package { 'metafor-agent':
    ensure  => latest,
    require => Package['jdk'],
  } ->
  file { 'metafor-agent-config':
    ensure  => present,
    path    => '/opt/metaforsoftware/agent/etc/discoveryAgent.xml',
    content => template('metafor/discoveryAgent.xml.erb'),
    owner   => 'metafor-agent',
    group   => 'metafor-agent',
    mode    => '0444',
  }
  service { 'metafor-agent':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    subscribe  => File['metafor-agent-config'],
  }
}
