namespace :services do
  desc 'Populate social media services'
  task :load => :environment do

    # Blip
    Admin::Service.create_with(
      handles_regex_eval: '/blip.tv$/',
      shortname: 'blip',
      display_name_eval: '<account> on Blip',
      account_matchers_eval: {
        path: '/\/(?<id>[\w-]+)$/'
      },
      service_url_example: 'http://www.blip.tv/username',
      service_url_canonical_eval: 'http://blip.tv/<account>',
      archived: true
    ).find_or_create_by(
      longname: 'Blip'
    )

    # Disqus
    Admin::Service.create_with(
      handles_regex_eval: '/disqus.com$/',
      shortname: 'disqus',
      display_name_eval: '<account> on Disqus',
      account_matchers_eval: {
        path: '/\/(?<id>[\w-]+)$/'
      },
      service_url_example: 'http://www.disqus.com/username',
      service_url_canonical_eval: 'http://disqus.com/<account>'
    ).find_or_create_by(
      longname: 'Disqus'
    )

    # Eventbrite
    Admin::Service.create_with(
      handles_regex_eval: '/eventbrite.com/',
      shortname: 'eventbrite',
      display_name_eval: '<account> on Eventbrite',
      account_matchers_eval: {
        path: '/o\/(?<id>[\w-]+)\/?/'
      },
      service_url_example: 'http://www.eventbrite.com/o/username',
      service_url_canonical_eval: 'http://www.eventbrite.com/o/#{username}'
    ).find_or_create_by(
      longname: 'Eventbrite'
    )

    # Facebook
    Admin::Service.create_with(
      handles_regex_eval: '/facebook.com$/',
      shortname: 'facebook',
      display_name_eval: '<account> on Facebook',
      account_matchers_eval: {
        conditional: {
          if: '/pages/',
          then: '/\/(?<id>\d+)$/',
        else: '/\/(?<id>[\w\.-]+)$/'
        }
      },
      service_url_example: 'https://www.facebook.com/username',
      service_url_canonical_eval: 'http://facebook.com/<account>'
    ).find_or_create_by(
      longname: 'Facebook'
    )

    # Flickr
    Admin::Service.create_with(
      handles_regex_eval: '/flickr.com$/',
      shortname: 'flickr',
      display_name_eval: '<account> on Flickr',
      account_matchers_eval: {
        path: '/(photos|people)\/(?<id>[\w@-]+)(\/)?$/'
      },
      service_url_example: 'http://flickr.com/photos/username',
      service_url_canonical_eval: 'http://flickr.com/photos/<account>'
    ).find_or_create_by(
      longname: 'Flickr'
    )

    # Foursquare
    Admin::Service.create_with(
      handles_regex_eval: '/foursquare.com$/',
      shortname: 'foursquare',
      display_name_eval: '<account> on Foursquare',
      account_matchers_eval: {
        path: '/\/(?<id>[\w-]+)$/'
      },
      service_url_example: 'http://www.foursquare.com/username',
      service_url_canonical_eval: 'http://foursquare.com/<account>',
      archived: true
    ).find_or_create_by(
      longname: 'Foursquare'
    )

    # GitHub
    Admin::Service.create_with(
      handles_regex_eval: '/github.com$/',
      shortname: 'github',
      display_name_eval: '<account> on GitHub',
      account_matchers_eval: {
        path: '/^\/(?<id>[\w-]+)/'
      },
      service_url_example: 'http://www.github.com/username',
      service_url_canonical_eval: 'http://github.com/<account>'
    ).find_or_create_by(
      longname: 'GitHub'
    )

    # Google+
    Admin::Service.create_with(
      handles_regex_eval: '/plus.google.com$/',
      shortname: 'google_plus',
      display_name_eval: 'Google Plus ID: <account>',
      account_matchers_eval: {
        conditional: {
          if: '/^(\/u\/0)?\/(?<id>\d+)(\/posts)?/',
          then: '/^(\/u\/0)?\/(?<id>\d+)(\/posts)?/',
        else: '/^(\/u\/0)?\/(?<id>\+\w+)(\/posts)?/'
        }
      },
      service_url_example: 'https://plus.google.com/username/posts',
      service_url_canonical_eval: 'https://plus.google.com/<account>'
    ).find_or_create_by(
      longname: 'Google+'
    )

    # Hulu
    Admin::Service.create_with(
      handles_regex_eval: '/hulu.com/',
      shortname: 'hulu',
      display_name_eval: '<account> on Hulu',
      account_matchers_eval: {
        path: '/^\/(?<id>[\w-]+)\/?/'
      },
      service_url_example: 'http://www.hulu.com/username',
      service_url_canonical_eval: 'http://Hulu.com/<account>'
    ).find_or_create_by(
      longname: 'Hulu'
    )

    # IdeaScale
    Admin::Service.create_with(
      handles_regex_eval: '/ideascale.com$/',
      shortname: 'ideascale',
      display_name_eval: '<account> on IdeaScale',
      account_matchers_eval: {
        host: '/^(?<id>[\w-]+)\.ideascale.com/'
      },
      service_url_example: 'http://username.ideascale.com/',
      service_url_canonical_eval: 'http://<account>.ideascale.com/'
    ).find_or_create_by(
      longname: 'IdeaScale'
    )

    # Instagram
    Admin::Service.create_with(
      handles_regex_eval: '/instagram.com$/',
      shortname: 'instagram',
      display_name_eval: '<account> on Instagram',
      account_matchers_eval: {
        path: '/^\/(?<id>[\w-]+)/',
        stop_words: ['p', 'popular', 'developer', 'press', 'about']
      },
      service_url_example: 'http://instagram.com/username',
      service_url_canonical_eval: 'http://instagram.com/<account>'
    ).find_or_create_by(
      longname: 'Instagram'
    )

    # LinkedIn
    Admin::Service.create_with(
      handles_regex_eval: '/linkedin.com$/',
      shortname: 'linkedin',
      display_name_eval: '<account> on LinkedIn',
      account_matchers_eval: {
        path: '/\/company\/(?<id>[\w.-]+)$/'
      },
      service_url_example: 'http://www.linkedin.com/company/username',
      service_url_canonical_eval: 'http://linkedin.com/company/<account>'
    ).find_or_create_by(
      longname: 'LinkedIn'
    )

    # Livestream
    Admin::Service.create_with(
      handles_regex_eval: '/livestream.com/',
      shortname: 'livestream',
      display_name_eval: '<account> on Livestream',
      account_matchers_eval: {
        path: '/\/(?<id>[\w-]+)$/'
      },
      service_url_example: 'http://new.livestream.com/username',
      service_url_canonical_eval: 'http://new.livestream.com/<account>',
      archived: true
    ).find_or_create_by(
      longname: 'Livestream'
    )

    # Medium
    Admin::Service.create_with(
      handles_regex_eval: '/medium.com/',
      shortname: 'medium',
      display_name_eval: '<account> on Medium',
      account_matchers_eval: {
        path: '/^\/@(?<id>[\w-]+)\/?/'
      },
      service_url_example: 'http://medium.com/@username',
      service_url_canonical_eval: 'http://medium.com/@#{username}'
    ).find_or_create_by(
      longname: 'Medium'
    )

    # Meetup
    Admin::Service.create_with(
      handles_regex_eval: '/meetup.com$/',
      shortname: 'meetup',
      display_name_eval: '<account> on Meetup',
      account_matchers_eval: {
        path: '/\/(?<id>[\w-]+)$/'
      },
      service_url_example: 'http://www.meetup.com/username',
      service_url_canonical_eval: 'http://meetup.com/<account>'
    ).find_or_create_by(
      longname: 'Meetup'
    )

    # Myspace
    Admin::Service.create_with(
      handles_regex_eval: '/myspace.com$/',
      shortname: 'myspace',
      display_name_eval: '<account> on Myspace',
      account_matchers_eval: {
        path: '/\/(?<id>[\w-]+)$/'
      },
      service_url_example: 'http://www.myspace.com/username',
      service_url_canonical_eval: 'http://myspace.com/<account>',
      archived: true
    ).find_or_create_by(
      longname: 'Myspace'
    )

    # Pinterest
    Admin::Service.create_with(
      handles_regex_eval: '/pinterest.com$/',
      shortname: 'pinterest',
      display_name_eval: '<account> on Pinterest',
      account_matchers_eval: {
        path: '/\/(?<id>[\w-]+)$/'
      },
      service_url_example: 'http://pinterest.com/username/',
      service_url_canonical_eval: 'http://pinterest.com/<account>/'
    ).find_or_create_by(
      longname: 'Pinterest'
    )

    # Posterous
    Admin::Service.create_with(
      handles_regex_eval: '/posterous.com$/',
      shortname: 'posterous',
      display_name_eval: '<account> on Posterous',
      account_matchers_eval: {
        host: '/^(?<id>[\w-]+)\.posterous.com/'
      },
      service_url_example: 'http://username.posterous.com/',
      service_url_canonical_eval: 'http://<account>.posterous.com/',
      archived: true
    ).find_or_create_by(
      longname: 'Posterous'
    )

    # Scribd
    Admin::Service.create_with(
      handles_regex_eval: '/scribd.com$/',
      shortname: 'scribd',
      display_name_eval: '<account> on Scribd',
      account_matchers_eval: {
        path: '/\/(?<id>[\w-]+)$/'
      },
      service_url_example: 'http://www.scribd.com/username',
      service_url_canonical_eval: 'http://scribd.com/<account>'
    ).find_or_create_by(
      longname: 'Scribd'
    )

    # SlideShare
    Admin::Service.create_with(
      handles_regex_eval: '/slideshare.net$/',
      shortname: 'slideshare',
      display_name_eval: '<account> on SlideShare',
      account_matchers_eval: {
        path: '/\/(?<id>[\w-]+)$/',
        stop_words: ['newsfeed', 'popular', 'most-downloaded', 'most-favorited', 'pro_accounts', 'popular', 'featured', 'features']
      },
      service_url_example: 'http://www.slideshare.net/username',
      service_url_canonical_eval: 'http://slideshare.net/<account>'
    ).find_or_create_by(
      longname: 'SlideShare'
    )

    # Socrata
    Admin::Service.create_with(
      handles_regex_eval: '/socrata.com$/',
      shortname: 'socrata',
      display_name_eval: '<account> on Socrata',
      account_matchers_eval: {
        host: '/^(?<id>[\w-]+)\.socrata.com/'
      },
      service_url_example: 'http://username.socrata.com/',
      service_url_canonical_eval: 'http://<account>.socrata.com/'
    ).find_or_create_by(
      longname: 'Socrata'
    )

    # Storify
    Admin::Service.create_with(
      handles_regex_eval: '/storify.com$/',
      shortname: 'storify',
      display_name_eval: '<account> on Storify',
      account_matchers_eval: {
        path: '/^\/(?<id>[\w-]+)/'
      },
      service_url_example: 'http://www.storify.com/username',
      service_url_canonical_eval: 'http://storify.com/<account>'
    ).find_or_create_by(
      longname: 'Storify'
    )

    # Tumblr
    Admin::Service.create_with(
      handles_regex_eval: '/tumblr.com$/',
      shortname: 'tumblr',
      display_name_eval: '<account> on Tumblr',
      account_matchers_eval: {
        host: '/^(?<id>[\w-]+)\.tumblr.com/'
      },
      service_url_example: 'http://username.tumblr.com/',
      service_url_canonical_eval: 'http://<account>.tumblr.com/'
    ).find_or_create_by(
      longname: 'Tumblr'
    )

    # Twitter
    Admin::Service.create_with(
      handles_regex_eval: '/twitter.com$/',
      shortname: 'twitter',
      display_name_eval: '@<account> on Twitter',
      account_matchers_eval: {
        fragment: '/\/(?<id>[\w-]+)$/'
      },
      service_url_example: 'http://twitter.com/username',
      service_url_canonical_eval: 'http://twitter.com/<account>'
    ).find_or_create_by(
      longname: 'Twitter'
    )

    # UserVoice
    Admin::Service.create_with(
      handles_regex_eval: '/uservoice.com$/',
      shortname: 'uservoice',
      display_name_eval: '<account> on UserVoice',
      account_matchers_eval: {
        host: '/^(?<id>[\w-]+)\.uservoice.com/'
      },
      service_url_example: 'http://username.uservoice.com/',
      service_url_canonical_eval: 'http://<account>.uservoice.com/'
    ).find_or_create_by(
      longname: 'UserVoice'
    )

    # Ustream
    Admin::Service.create_with(
      handles_regex_eval: '/ustream.tv$/',
      shortname: 'ustream',
      display_name_eval: '<account> on Ustream',
      account_matchers_eval: {
        path: '/\/(?<id>[\w-]+)$/'
      },
      service_url_example: 'http://www.ustream.tv/username',
      service_url_canonical_eval: 'http://ustream.tv/<account>'
    ).find_or_create_by(
      longname: 'Ustream'
    )

    # Vimeo
    Admin::Service.create_with(
      handles_regex_eval: '/vimeo.com$/',
      shortname: 'vimeo',
      display_name_eval: '<account> on Vimeo',
      account_matchers_eval: {
        nil: '/^\/\d+$/',
        conditional: {
          if: '/channels/',
          then: '/\/(?<id>[\w-]+)$/',
          else: '/^\/(?<id>[\w-]+)/'
        }
      },
      service_url_example: 'http://vimeo.com/username',
      service_url_canonical_eval: 'http://vimeo.com/<account>'
    ).find_or_create_by(
      longname: 'Vimeo'
    )

    # Yelp
    Admin::Service.create_with(
      handles_regex_eval: '/yelp.com$/',
      shortname: 'yelp',
      display_name_eval: '<account> on Yelp',
      account_matchers_eval: {
        path: '/biz\/(?<id>[\w-]+)\/?/'
      },
      service_url_example: 'http://www.yelp.com/biz/username',
      service_url_canonical_eval: 'http://www.yelp.com/biz/<account>'
    ).find_or_create_by(
      longname: 'Yelp'
    )

    # YouTube
    Admin::Service.create_with(
      handles_regex_eval: '/youtube.com$/',
      shortname: 'youtube',
      display_name_eval: '<account> on YouTube',
      account_matchers_eval: {
        path: '/^(\/user)?\/(?<id>[\w-]+)/',
        stop_words: ['watch', 'movies', 'channel', 'music', 'shows', 'live', 'sports', 'education', 'news']
      },
      service_url_example: 'http://www.youtube.com/username',
      service_url_canonical_eval: 'http://youtube.com/<account>'
    ).find_or_create_by(
      longname: 'YouTube'
    )
  end
end
