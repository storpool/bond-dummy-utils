Name:		ifup-dummy
Version:	0.1.0
Release:	1%{?dist}
Summary:	Bring up a dummy network interface
URL:		https://github.com/storpool/ifup-dummy/

Source0:	http://repo.storpool.com/public/files/ifup-dummy/ifup-dummy-0.1.0.tar.gz
License:	BSD

BuildArch:	noarch

Requires:	initscripts

%description
The ifup-dummy script allows the sysconfig/network-scripts infrastructure
to bring up a dummy interface, either by itself or as part of a bond
interface.

%prep
%autosetup

%build
make %{?_smp_mflags}

%install
%make_install SYSCONFDIR='%{_sysconfdir}' INSTALL_SCRIPT='install -m 0755'

%files
%{_sysconfdir}/sysconfig/network-scripts/ifup-dummy

%changelog
* Fri Oct 26 2018 Peter Pentchev <pp@storpool.com> - 0.1.0-1
- Initial version.
