# Change log for bond-dummy-utils

## 0.3.0 (not yet)
- Teach bond-dummy-enslave to using iproute2 to enslave interfaces
  instead of the obsolete ifenslave tool.
- Make bond-dummy-enslave a bit more resilient if some interfaces have
  already been created.
- Make bond-dummy-enslave exit on errors.

## 0.2.1 (2019-02-25)

- Fix an ifup-dummy bug when NAME is not specified in
  the configuration, but DEVICE is.

## 0.2.0 (2018-11-01)

- Rename the package to bond-dummy-utils.
- Add the GPL-2 license text and license blurbs.
- Add the bond-dummy-add and the bond-dummy-enslave utilities.
- Conditionally install the proper set of utilities depending on
  the Linux distribution; may be overridden by setting any of
  the `INSTALL_DEBIAN`, `INSTALL_REDHAT`, `SKIP_INSTALL_DEBIAN`, or
  `SKIP_INSTALL_REDHAT` environment variables to non-empty strings.

## 0.1.0 (2018-10-31)

- Initial semi-public release as ifup-dummy.
