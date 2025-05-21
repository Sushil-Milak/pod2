
# pod2

[![CI Status](https://img.shields.io/travis/Sushil Milak/pod2.svg?style=flat)](https://travis-ci.org/Sushil Milak/pod2)
[![Version](https://img.shields.io/cocoapods/v/pod2.svg?style=flat)](https://cocoapods.org/pods/pod2)
[![License](https://img.shields.io/cocoapods/l/pod2.svg?style=flat)](https://cocoapods.org/pods/pod2)
[![Platform](https://img.shields.io/cocoapods/p/pod2.svg?style=flat)](https://cocoapods.org/pods/pod2)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

pod2 is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'pod2'
```

## Author

Sushil Milak, sushil.milak@va.gov

## License

pod2 is available under the MIT license. See the LICENSE file for more info.


## Notes

#######
# Pods folder. This is where MODEL is put. DEFINATION
## This is where initial model is kept.
## To use our ACS dependencies, open command prompt at Pods/Podfile  and 'pod install'.  Pods/Development Pods/pod1/Source/VFMPMainViewR cannot find ACS library error goes away.


### Where are my pods?

#### Command to create pods
/Users/sushil/Desktop/repo/login_module/pods/myPod/pod1
pod lib create pod1
make ios development target 16 at all places (targets, Pods project).

create repo at Github or Bitbucket.
For Github.
Create repo. Commit. Put tag. Commit. Once ready for release, DO A RELEASE before creating PUBLIC pod.
git init
git add -A
git commit -m "Message"
git remote add origin https://github.com/S**/blah.git ~
git push -u origin master

GIT release

Now publish for pod.
pod trunk register 'your email-id'
pod lib lint podlibrary**.podspec (from the project folder)
pod trunk push podlibrary**.podspec

now pod should be available, if it is public. Need to see how to do for PRIVATE.
We can do local as well.

How to use in other project:
Check the PodFile inside /Pods folder. Use this as a starter
OtherProject: pod init. Update pod file. pod install. pod update.

pod cache clean --all
pod --verbose --allow-warnings --no-clean  lib lint

Questions:
Where to put Firebase dependencies (podspec file or Package).
Trying adding SPM firebase (look inside beneproto podfile )


# pod2
