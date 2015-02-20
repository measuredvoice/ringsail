# Social Media Registry (program information)

[![Build Status](https://travis-ci.org/ctacdev/social-media-registry.svg?branch=develop)](https://travis-ci.org/ctacdev/social-media-registry)
[![Coverage Status](https://coveralls.io/repos/ctacdev/social-media-registry/badge.svg?branch=develop)](https://coveralls.io/r/ctacdev/social-media-registry?branch=develop)

* [API Documentation](http://www.usa.gov/About/developer-resources/social-media-registry.shtml)
* [Verification Page](http://www.usa.gov/Contact/verify-social-media.shtml)
* [Registration Page](http://registry.usa.gov/embed/find)


# Ringsail (the underlying software) 

Ringsail is a registry built in Ruby on Rails to gather, organize, and make available information about social media accounts and mobile applications run by large organizations.

## Purpose

The U.S. General Services Administration created Ringsail as a registry of all social media accounts managed by U.S. federal government agencies and programs. We hope that any large organization that manages disparate social media accounts will be able to use it.

As built, it allows anyone with a .gov or .mil email address to register a social media account as an official government account. The information gathered about these social media accounts is then made available via an API.

# Development

Ringsail is currently being developed.  This document should be considered a living document, and will grow over time.  Organization is always appreciated.

## Requirements

Ringsail is built on Ruby 2.1.5 and Rails 4.1.1, backed by a MySQL 5 database (or greater). 

## Setup

Commands:
rake db:create
rake db:migrate
rake db:seed
rails s

## Information on specific features

### Single Sign On

For the purposes of Single Sign-On (SSO), Ringsail integrates with OMB.MAX.  For this integration to work, the domain name of the service must be configured with OMB MAX as an external dependency.  It also requires configuration of groups in the secrets.yml file (the user and administrator groups to check against). Leaving these blanks will cause every user account to have either user level or administrator level access.

In development mode, users form the db:seeds file will be created with each level of access available in the system.  There should be no need to integrate with a CAS provider for development purposes

If you are looking to run your own version of the application, either modify the authentication mechanism or integrate with a cas provider.

### Social Media Accounts

Social media accounts are stored as Outlets internally.  This is for the purposes of naming as having "accounts" as a name is particularly useful, and more closely matches with terminiology of the web communication divisions of various government agencies.

The major goals of social media accounts is to be able to search, sort, and verify their authenticity.
  
### Social Media Plugins

Social Media services change rapidly, so Ringsail allows new services to be added as plug-ins in the folder 'lib/services'

See `lib/services/twitter_service.rb` for a good example of the service plug-in style.

You can generate a new plugin using a generator with the format below:

'rails g service service_name'

where service name is the name of the service, and the key that will be used in the database to tie services of the same type together.

To submit a new service for inclusion in this registry, please fork this repository, add your service, and submit a pull request with the proposed change.

All services should include the same methods, and return sensible results.

### Mobile Applications
Mobile applications are stored as MobileApps internally.  This name much more closely reflects their purpose than social media accounts. 

The major goals of mobile applications is to be able to search, sort, and verify their authenticity.

### Mobile Application Plugins

Mobile application apis change less rapidly than services, but we've deigned to treat them in a fashion similar to social media plugins, to allow easy expansion and development.  We will be abl adding clases for the handling of mobile application apis to /lib/mobile/

### Workflow

Current workflow consists of regular users submitting social media and mobile applications into a "Pending" status.  Administrators can review these and place them in an 'Published' state.  After 6 months without being modified, records will be placed in an "under review" status and contacts for their related agency and record will be notified.  These "under review" items will be completely viewable by the public, but administrative users may archive them if they are not attended to.