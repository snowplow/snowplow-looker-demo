# Copyright (c) 2013-2015 Snowplow Analytics Ltd. All rights reserved.
#
# This program is licensed to you under the Apache License Version 2.0,
# and you may not use this file except in compliance with the Apache License Version 2.0.
# You may obtain a copy of the Apache License Version 2.0 at http://www.apache.org/licenses/LICENSE-2.0.
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the Apache License Version 2.0 is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the Apache License Version 2.0 for the specific language governing permissions and limitations there under.
#
# Authors: Christophe Bogaert
# Copyright: Copyright (c) 2013-2015 Snowplow Analytics Ltd
# License: Apache License Version 2.0
#
# Data Model: Demo
# Version: 1.0.0

- dashboard: visits
  title: Snowplow Demo – Visits
  layout: grid
  rows:
    - elements: [total_visitors, total_visits, page_views_per_visit, time_engaged_per_visit]
      height: 250
    - elements: [new_versus_returning_pie, referrer_medium_pie, landing_page_pie, top_countries_pie]
      height: 250
    - elements: [visits_new_versus_returning_trend, time_engaged_per_landing_page_trend]
      height: 500
    - elements: [visits_landing_page_trend, conversion_rate_landing_page_trend]
      height: 500
    - elements: [visits_first_visit_cohort, bounce_rate_landing_page_trend]
      height: 500
    - elements: [top_paths_table, top_link_clicks_table]
      height: 500
    - elements: [top_bounce_pages_table]
      height: 500
  
  filters:
  
  - name: date
    title: Date
    type: date_filter
    default_value: 12 Weeks
  
  - name: new_versus_returning
    title: New versus Returning
    type: field_filter
    explore: visits
    field: visits.new_versus_returning
  
  - name: referrer_medium
    title: Referrer Medium
    type: field_filter
    explore: visits
    field: visits.referrer_medium
  
  - name: landing_page_section
    title: Landing Page
    type: field_filter
    explore: visits
    field: visits.landing_page_section
  
  - name: top_countries
    title: Country
    type: field_filter
    explore: visits
    field: visits.top_countries
  
  - name: visitor_bounced
    title: Visitor Bounced
    type: field_filter
    explore: visits
    field: visits.visitor_bounced
  
  elements:
  
  # Row 1 – Basic metrics
  
  - name: total_visitors
    title: Visitors
    type: single_value
    model: snowplow_demo
    explore: visits
    measures: visits.total_visitors
    listen:
      date: visits.timestamp_date
      new_versus_returning: visits.new_versus_returning
      referrer_medium: visits.referrer_medium
      top_countries: visits.top_countries
      landing_page_section: visits.landing_page_section
      visitor_bounced: visits.visitor_bounced
    value_format: '[>=1000000] #,##0.0,,"M";[<1000] 0;#,##0.0,"k"'
    font_size: medium
  
  - name: total_visits
    title: Visits
    type: single_value
    model: snowplow_demo
    explore: visits
    measures: visits.total_visits
    listen:
      date: visits.timestamp_date
      new_versus_returning: visits.new_versus_returning
      referrer_medium: visits.referrer_medium
      top_countries: visits.top_countries
      landing_page_section: visits.landing_page_section
      visitor_bounced: visits.visitor_bounced
    value_format: '[>=1000000] #,##0.0,,"M";[<1000] 0;#,##0.0,"k"'
    font_size: medium
  
  - name: page_views_per_visit
    title: Page Views per Visit
    type: single_value
    model: snowplow_demo
    explore: visits
    measures: visits.page_views_per_visit
    listen:
      date: visits.timestamp_date
      new_versus_returning: visits.new_versus_returning
      referrer_medium: visits.referrer_medium
      top_countries: visits.top_countries
      landing_page_section: visits.landing_page_section
      visitor_bounced: visits.visitor_bounced
    font_size: medium
  
  - name: time_engaged_per_visit
    title: Time Engaged per Visit
    type: single_value
    model: snowplow_demo
    explore: visits
    measures: visits.time_engaged_per_visit
    listen:
      date: visits.timestamp_date
      new_versus_returning: visits.new_versus_returning
      referrer_medium: visits.referrer_medium
      top_countries: visits.top_countries
      landing_page_section: visits.landing_page_section
      visitor_bounced: visits.visitor_bounced
    font_size: medium
  
  # Row 2 – Pie charts
  
  - name: new_versus_returning_pie
    title: New versus Returning
    type: looker_pie
    model: snowplow_demo
    explore: visits
    dimensions: visits.new_versus_returning
    measures: visits.total_visits
    listen:
      date: visits.timestamp_date
      new_versus_returning: visits.new_versus_returning
      referrer_medium: visits.referrer_medium
      top_countries: visits.top_countries
      landing_page_section: visits.landing_page_section
      visitor_bounced: visits.visitor_bounced
  
  - name: referrer_medium_pie
    title: Referrer Medium
    type: looker_pie
    model: snowplow_demo
    explore: visits
    dimensions: visits.referrer_medium_html
    measures: visits.total_visits
    listen:
      date: visits.timestamp_date
      new_versus_returning: visits.new_versus_returning
      referrer_medium: visits.referrer_medium
      top_countries: visits.top_countries
      landing_page_section: visits.landing_page_section
      visitor_bounced: visits.visitor_bounced
  
  - name: landing_page_pie
    title: Landing Page
    type: looker_pie
    model: snowplow_demo
    explore: visits
    dimensions: visits.landing_page_section_html
    measures: visits.total_visits
    listen:
      date: visits.timestamp_date
      new_versus_returning: visits.new_versus_returning
      referrer_medium: visits.referrer_medium
      top_countries: visits.top_countries
      landing_page_section: visits.landing_page_section
      visitor_bounced: visits.visitor_bounced
  
  - name: top_countries_pie
    title: Country
    type: looker_pie
    model: snowplow_demo
    explore: visits
    dimensions: visits.top_countries
    measures: visits.total_visits
    listen:
      date: visits.timestamp_date
      new_versus_returning: visits.new_versus_returning
      referrer_medium: visits.referrer_medium
      top_countries: visits.top_countries
      landing_page_section: visits.landing_page_section
      visitor_bounced: visits.visitor_bounced
  
  # Row 3 – Trends
  
  - name: visits_new_versus_returning_trend
    title: Visits – New versus Returning
    type: looker_area
    model: snowplow_demo
    explore: visits
    dimensions: visits.timestamp_week
    measures: visits.total_visits
    pivots: visits.new_versus_returning
    listen:
      date: visits.timestamp_date
      # new_versus_returning: visits.new_versus_returning
      referrer_medium: visits.referrer_medium
      top_countries: visits.top_countries
      landing_page_section: visits.landing_page_section
      visitor_bounced: visits.visitor_bounced
    interpolation: monotone
    show_null_points: true
    stacking: normal
  
  - name: time_engaged_per_landing_page_trend
    title: Time Engaged per Landing Page
    type: looker_line
    model: snowplow_demo
    explore: visits
    dimensions: [visits.timestamp_week, visits.landing_page_section]
    pivots: [visits.landing_page_section]
    measures: [visits.time_engaged_per_visit]
    filters:
      visits.landing_page_section: homepage, analytics, blog
    listen:
      date: visits.timestamp_date
      new_versus_returning: visits.new_versus_returning
      referrer_medium: visits.referrer_medium
      # landing_page_section: visits.landing_page_section
      top_countries: visits.top_countries
      visitor_bounced: visits.visitor_bounced
    sorts: [visits.timestamp_week desc]
    interpolation: monotone
    show_null_points: true
    stacking: ''
  
  # Row 4 – Trends
  
  - name: visits_landing_page_trend
    title: Vistis – Landing Page
    type: looker_area
    model: snowplow_demo
    explore: visits
    dimensions: visits.timestamp_week
    measures: visits.total_visits
    pivots: visits.landing_page_section
    listen:
      date: visits.timestamp_date
      new_versus_returning: visits.new_versus_returning
      referrer_medium: visits.referrer_medium
      top_countries: visits.top_countries
      # landing_page_section: visits.landing_page_section
      visitor_bounced: visits.visitor_bounced
    interpolation: monotone
    show_null_points: true
    stacking: normal
  
  - name: conversion_rate_landing_page_trend
    title: Conversion Rate per Landing Page
    type: looker_line
    model: snowplow_demo
    explore: visits
    dimensions: [visits.timestamp_week, visits.landing_page_section]
    pivots: [visits.landing_page_section]
    measures: [visits.conversion_rate]
    filters:
      visits.landing_page_section: homepage, analytics, blog
    listen:
      date: visits.timestamp_date
      new_versus_returning: visits.new_versus_returning
      referrer_medium: visits.referrer_medium
      # landing_page_section: visits.landing_page_section
      top_countries: visits.top_countries
      visitor_bounced: visits.visitor_bounced
    sorts: [visits.timestamp_week desc]
    interpolation: monotone
    show_null_points: true
    stacking: ''
  
  # Row 5 – Segmentation and bounce rate
  
  - name: visits_first_visit_cohort
    title: Cohorts – First Visit
    type: looker_area
    model: snowplow_demo
    explore: visits
    dimensions: [visitors.timestamp_month, visits.timestamp_month]
    pivots: [visitors.timestamp_month]
    measures: [visits.total_visits]
    sorts: [visits.timestamp_week desc, visitors.timestamp_month]
    show_null_points: true
    stacking: normal
  
  - name: bounce_rate_landing_page_trend
    title: Bounce Rate per Landing Page
    type: looker_line
    model: snowplow_demo
    explore: visits
    dimensions: [visits.timestamp_week, visits.landing_page_section]
    pivots: [visits.landing_page_section]
    measures: [visits.bounce_rate]
    filters:
      visits.landing_page_section: homepage, analytics, blog
    listen:
      date: visits.timestamp_date
      new_versus_returning: visits.new_versus_returning
      referrer_medium: visits.referrer_medium
      # landing_page_section: visits.landing_page_section
      top_countries: visits.top_countries
      # visitor_bounced: visits.visitor_bounced
    sorts: [visits.timestamp_week desc]
    interpolation: monotone
    show_null_points: true
    stacking: ''
  
  # Row 6 – Paths and link clicks
  
  - name: top_paths_table
    title: Conversion Rate per Landing Page & Next Section
    type: table
    model: snowplow_demo
    explore: visits
    dimensions: [visits.path_2]
    measures: [visits.total_visits, visits.conversion_rate]
    filters:
      visits.total_sections: '>1'
    listen:
      date: visits.timestamp_date
      new_versus_returning: visits.new_versus_returning
      referrer_medium: visits.referrer_medium
      top_countries: visits.top_countries
      landing_page_section: visits.landing_page_section
      visitor_bounced: visits.visitor_bounced
    sorts: visits.total_visits desc
    limit: 15
  
  - name: top_link_clicks_table
    title: Non-Snowplow Link Clicks
    type: table
    model: snowplow_demo
    explore: link_clicks
    dimensions: link_clicks.target_host
    measures: link_clicks.count
    filters:
      link_clicks.github_snowplow: 'No'
      link_clicks.internal: 'No'
    listen:
      date: link_clicks.timestamp_date
      # new_versus_returning: visits.new_versus_returning
      # referrer_medium: visits.referrer_medium
      # top_countries: visits.top_countries
      # landing_page_section: visits.landing_page_section
      # visitor_bounced: visits.visitor_bounced
    sorts: link_clicks.count desc
    limit: 15
  
  # Row 7 – Bounce rates
  
  - name: top_bounce_pages_table
    title: Bounce Rate per Landing Page
    type: table
    model: snowplow_demo
    explore: visits
    dimensions: [visits.landing_page_title, visits.landing_page_section]
    measures: [visits.total_visits, visits.bounce_rate]
    filters:
      visits.total_visits: '>=50'
    listen:
      date: visits.timestamp_date
      new_versus_returning: visits.new_versus_returning
      referrer_medium: visits.referrer_medium
      top_countries: visits.top_countries
      landing_page_section: visits.landing_page_section
      # visitor_bounced: visits.visitor_bounced
    sorts: visits.bounce_rate desc
    limit: 15
  