---
# An instance of the Contact widget.
# Documentation: https://sourcethemes.com/academic/docs/page-builder/
widget: contact

# This file represents a page section.
headless: true

# Order that this section appears on the page.
weight: 70

content:
  title: Contact
  subtitle:
  text: |-
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam mi diam, venenatis ut magna et, vehicula efficitur enim.
  # Contact (add or remove contact options as necessary)
  email: D.Makowski@sussex.ac.uk
  # phone: 888 888 88 88
  # appointment_url: 'https://calendly.com'
  address:
    street: Pevensey 1 - room 2B7, School of Psychology, University of Sussex
    # city: Brighton
    # region: CA
    # postcode: 'BN1 9QH, UK'
    # country: UK
    # country_code: UK
  directions: Brighton, BN1 9QH, UK
  # office_hours:
  #   - 'Monday 10:00 to 13:00'
  #   - 'Wednesday 09:00 to 10:00'
  contact_links:
    - icon: twitter
      icon_pack: fab
      name: Follow me
      link: 'https://twitter.com/Dom_Makowski'
    # - icon: skype
    #   icon_pack: fab
    #   name: Skype Me
    #   link: 'skype:echo123?call'
    # - icon: video
    #   icon_pack: fas
    #   name: Zoom Me
    #   link: 'https://zoom.com'
  coordinates:
    latitude: '50.86518889665293'
    longitude: '-0.08690505092272546'
  # Automatically link email and phone or display as text?
  autolink: true
  # Email form provider
  form:
    provider:
    formspree:
      id:
    netlify:
      # Enable CAPTCHA challenge to reduce spam?
      captcha: false
design:
  columns: '2'
---
