# Web Performance Static Page

## 1. Test Goals

This test is designed to assess the performance of static web pages within a web infrastructure. The primary goal is to evaluate the loading times, responsiveness, and overall efficiency of static web pages under various conditions. By simulating different user interactions and network environments, this suite aims to ensure that these web pages are optimally delivered with minimal delay and maximum reliability. This is crucial for providing a seamless and efficient user experience, as well as for maintaining high standards of web performance, particularly in scenarios where rapid access to information is essential.

## 2. Test Description

Validate Network Application performance by extracting download/upload and net/gross speed from bytes and time.

## 3. Inputs

Environment Variables that must be specified:
- `web_performance_static_page_target`
- `web_performance_static_page_web_speed_net_threshold_bps`

Example:
- `export web_performance_static_page_target=https://google.pt`
- `export web_performance_static_page_web_speed_net_threshold_bps=5000000 #5 MBs per second`

## 4. Outputs

### 4.1. Example - Test Succeeded

```
➜ ./run_test.sh
==============================================================================
Web Performance Static Page
==============================================================================
Web Performance Static Page.Web Performance Static Page
==============================================================================
Web Performance Static Page - Network Application - Web performanc... ..WEB speed (net, gross) (11324620.8, 368640.0) kbps, thresholds (11324620.8, 368640.0), target https://google.pt
Web Performance Static Page - Network Application - Web performanc... | PASS |
------------------------------------------------------------------------------
Web Performance Static Page.Web Performance Static Page               | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Web Performance Static Page                                           | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/web_performance_static_page/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/web_performance_static_page/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/web_performance_static_page/report.html
```

### 4.2. Example - Test Failed

```
➜ ./run_test.sh
==============================================================================
Web Performance Static Page
==============================================================================
Web Performance Static Page.Web Performance Static Page
==============================================================================
Web Performance Static Page - Network Application - Web performanc... | FAIL |
'1241513984.0 > 20000000000' should be true.
------------------------------------------------------------------------------
Web Performance Static Page.Web Performance Static Page               | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Web Performance Static Page                                           | FAIL |
1 test, 0 passed, 1 failed
==============================================================================
Output:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/web_performance_static_page/output.xml
Log:     /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/web_performance_static_page/log.html
Report:  /Users/eduardosantos/Documents/Bolsa 5GASP/repos/CICD_LTR/ftp/tests/web_performance_static_page/report.html
```

## 5. Requirements

### 5.1. OS-Level Requirements

`None`

### 5.2. Python Requirements

```
robotframework==6.0.2
requests==2.28.2
```