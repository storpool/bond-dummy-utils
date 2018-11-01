# Change log for bond-dummy-utils

## 0.2.0 (not yet)

- Rename the package to bond-dummy-utils.
- Add the bond-dummy-add and the bond-dummy-enslave utilities.
- Conditionally install the proper set of utilities depending on
  the Linux distribution; may be overridden by setting any of
  the `INSTALL_DEBIAN`, `INSTALL_REDHAT`, `SKIP_INSTALL_DEBIAN`, or
  `SKIP_INSTALL_REDHAT` environment variables to non-empty strings.

## 0.1.0 (2018-10-31)

- Initial semi-public release as ifup-dummy.
