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
    - elements: [new_versus_returning_pie, referrer_medium_pie, top_countries_pie, landing_section_pie]
      height: 250
  
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
  
  - name: top_countries
    title: Country
    type: field_filter
    explore: visits
    field: visits.top_countries
  
  - name: landing_page_section
    title: Landing Page
    type: field_filter
    explore: visits
    field: visits.landing_page_section
  
  elements:
  
  # Basic metrics
  
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
    value_format: '#,##0"s"'
    font_size: medium
  
  # Pie charts
  
  - name: new_versus_returning_pie
    title: New versus Returning
    type: looker_pie
    explore: visits
    dimensions: visits.new_versus_returning
    measures: visits.total_visits
    listen:
      date: visits.timestamp_date
      new_versus_returning: visits.new_versus_returning
      referrer_medium: visits.referrer_medium
      top_countries: visits.top_countries
      landing_page_section: visits.landing_page_section
  
  - name: referrer_medium_pie
    title: Referrer Medium
    type: looker_pie
    explore: visits
    dimensions: visits.referrer_medium
    measures: visits.total_visits
    listen:
      date: visits.timestamp_date
      new_versus_returning: visits.new_versus_returning
      referrer_medium: visits.referrer_medium
      top_countries: visits.top_countries
      landing_page_section: visits.landing_page_section
  
  - name: top_countries_pie
    title: Top Countries
    type: looker_pie
    explore: visits
    dimensions: visits.top_countries
    measures: visits.total_visits
    listen:
      date: visits.timestamp_date
      new_versus_returning: visits.new_versus_returning
      referrer_medium: visits.referrer_medium
      top_countries: visits.top_countries
      landing_page_section: visits.landing_page_section
  
  - name: landing_section_pie
    title: Landing Pages
    type: looker_pie
    explore: visits
    dimensions: visits.landing_page_section
    measures: visits.total_visits
    listen:
      date: visits.timestamp_date
      new_versus_returning: visits.new_versus_returning
      referrer_medium: visits.referrer_medium
      top_countries: visits.top_countries
      landing_page_section: visits.landing_page_section
  