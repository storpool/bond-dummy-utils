Name:		bond-dummy-utils
Version:	0.2.0
Release:	1%{?dist}
Summary:	Bring up a dummy network interface
URL:		https://github.com/storpool/bond-dummy-utils/

Source0:	http://repo.storpool.com/public/files/bond-dummy-utils/bond-dummy-utils-0.2.0.tar.gz
License:	GPLv2

BuildArch:	noarch

Requires:	initscripts

Provides:	ifup-dummy = 0.2.0-1%{?dist}
Obsoletes:	ifup-dummy < 0.1.0-2

%description
The ifup-dummy script allows the sysconfig/network-scripts infrastructure
to bring up a dummy interface, either by itself or as part of a bond
interface.

The bond-dummy-add script adds a dummy interface to a bond interface once
the latter has been configured.

%prep
%autosetup

%build
make %{?_smp_mflags}

%install
%make_install MANDIR='%{_mandir}/man' SBINDIR='%{_sbindir}' SYSCONFDIR='%{_sysconfdir}' INSTALL_SCRIPT='install -m 0755' INSTALL_DATA='install -m 0644' INSTALL_REDHAT=1 SKIP_INSTALL_DEBIAN=1

%files
%{_mandir}/man8/bond-dummy-add.8.gz
%{_sbindir}/bond-dummy-add
%{_sysconfdir}/sysconfig/network-scripts/ifup-dummy

%changelog
* Thu Nov  1 2018 Peter Pentchev <pp@storpool.com> - 0.2.0-1
- New upstream version.
- Rename the package to bond-dummy-utils.

* Fri Oct 26 2018 Peter Pentchev <pp@storpool.com> - 0.1.0-1
- Initial version.
