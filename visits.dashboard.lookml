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
    - elements: [visits_new_versus_returning_area, time_engaged_line]
      height: 500
    - elements: [visits_landing_page_section_trend, conversion_rate_trend]
      height: 500
    - elements: [top_paths_table, cohort_initial_month]
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
  
  #- name: funnel_referrer
    #title: Funnel – Referrer Medium
    #type: field_filter
    #explore: visits
    #field: visits.referrer_medium
    #default_value: 'search'
    
  #- name: funnel_section_1
    #title: Funnel – First section
    #type: field_filter
    #explore: visits
    #field: visits.section_1
    #default_value: 'blog'
    
  #- name: funnel_section_2
    #title: Funnel – Next Section
    #type: field_filter
    #explore: visits
    #field: visits.section_2
    #default_value: 'analytics'
  
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
  
  - name: referrer_medium_pie
    title: Referrer Medium
    type: looker_pie
    model: snowplow_demo
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
  
  - name: landing_section_pie
    title: Landing Pages
    type: looker_pie
    model: snowplow_demo
    explore: visits
    dimensions: visits.landing_page_section
    measures: visits.total_visits
    listen:
      date: visits.timestamp_date
      new_versus_returning: visits.new_versus_returning
      referrer_medium: visits.referrer_medium
      top_countries: visits.top_countries
      landing_page_section: visits.landing_page_section
  
  # Trends – Part 1
  
  - name: visits_new_versus_returning_area
    title: New versus Returning
    type: looker_area
    model: snowplow_demo
    explore: visits
    dimensions: visits.timestamp_week
    measures: visits.total_visits
    pivots: visits.new_versus_returning
    listen:
      date: visits.timestamp_date
      new_versus_returning: visits.new_versus_returning
      referrer_medium: visits.referrer_medium
      top_countries: visits.top_countries
      landing_page_section: visits.landing_page_section
    interpolation: monotone
    show_null_points: true
    stacking: normal
  
  - name: time_engaged_line
    title: Time Engaged per Landing Page Section
    type: looker_line
    model: snowplow_demo
    explore: visits
    dimensions: visits.timestamp_week
    pivots: visits.landing_page_section_restricted
    measures: visits.time_engaged_per_visit
    listen:
      date: visits.timestamp_date
      new_versus_returning: visits.new_versus_returning
      referrer_medium: visits.referrer_medium
      top_countries: visits.top_countries
      landing_page_section: visits.landing_page_section
    interpolation: monotone
    show_null_points: true
    stacking: ''
  
  # Trends – Part 2
  
  - name: visits_landing_page_section_trend
    title: Visits per Landing Page Section
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
      landing_page_section: visits.landing_page_section
    interpolation: monotone
    show_null_points: true
    stacking: normal
  
  - name: conversion_rate_trend
    title: Conversion Rate per Landing Page Section
    type: looker_line
    model: snowplow_demo
    explore: visits
    dimensions: visits.timestamp_week
    pivots: visits.landing_page_section_restricted
    measures: visits.conversion_rate
    listen:
      date: visits.timestamp_date
      new_versus_returning: visits.new_versus_returning
      referrer_medium: visits.referrer_medium
      top_countries: visits.top_countries
      landing_page_section: visits.landing_page_section
    interpolation: monotone
    show_null_points: true
    stacking: ''
  
  # Paths
  
  - name: top_paths_table
    title: Top Paths
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
    sorts: visits.total_visits desc
    limit: 15
  
  # Cohort analysis
  
  - name: cohort_initial_month
    title: Basic Cohort Analysis
    type: looker_area
    model: snowplow_demo
    explore: visits
    dimensions: [visitors.timestamp_month, visits.timestamp_week]
    pivots: [visitors.timestamp_month]
    measures: [visits.total_visits]
    sorts: [visits.timestamp_week desc, visitors.timestamp_month]
    show_null_points: true
    stacking: normal #percent
    interpolation: monotone
    show_null_points: true
  
  # Funnel
  
  #- name: conversion_funnel
  #  title: Funnel
  #  type: looker_column
  #  model: snowplow_demo
  #  explore: visits
  #  measures: [funnel.event_1_count_sessions, funnel.event_2_count_sessions, funnel.event_3_count_sessions,
  #    funnel.event_4_count_sessions]
  #  listen:
  #    funnel_referrer: visits.referrer_medium
  #    funnel_section_1: visits.
  #    funnel_section_2: page_views.event_3
    #show_dropoff: true
    #show_value_labels: true
    #show_view_names: true
    #show_null_labels: false
    #y_axis_gridlines: true
    #show_y_axis_labels: true
    #show_y_axis_ticks: true
    #y_axis_combined: true
    #y_axis_labels: [Count Sessions]
    #x_axis_gridlines: false
    #show_x_axis_label: true
    #show_x_axis_ticks: true
    #series_labels:
      #funnel.event_1_count_sessions: Event 1
      #funnel.event_2_count_sessions: Event 2
      #funnel.event_3_count_sessions: Event 3
      #funnel.event_4_count_sessions: Event 4
    #stacking: ''
    #x_axis_scale: auto
  