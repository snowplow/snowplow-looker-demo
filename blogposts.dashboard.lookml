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

- dashboard: blogposts
  title: Snowplow Demo – Blogposts
  layout: grid
  rows:
    - elements: [bp_page_views, bp_time_engaged, bp_share_of_entries, bp_percentage_returning]
      height: 250
    - elements: [blog_source]
      height: 500
    #- elements: [blog_posts_published]
    #  height: 250
    - elements: [bp_views_over_time, bp_cumulative_views_over_time]
      height: 500
    - elements: [bp_paths, blog_breadcrumb]
      height: 350
    - elements: [bp_top_posts]
      height: 350
  
  filters:
  
  - name: date
    title: Date
    type: date_filter
    default_value: 26 Weeks
  
  elements:
  
  # Basic metrics
  
  - name: bp_page_views
    title: Page Views
    type: single_value
    model: snowplow_demo
    explore: page_views
    measures: page_views.count
    listen:
      date: page_views.first_touch_date
    filters:
      page_views.blogpost: true
    value_format: '[>=1000000] #,##0.0,,"M";[<1000] 0;#,##0.0,"k"'
    font_size: medium
  
  - name: bp_time_engaged
    title: Time Engaged
    type: single_value
    model: snowplow_demo
    explore: page_views
    measures: page_views.total_time_engaged_in_hours
    listen:
      date: page_views.first_touch_date
    filters:
      page_views.blogpost: true
    value_format: '#,##0"h"'
    font_size: medium
  
  - name: bp_share_of_entries
    title: Blogposts % Inbound Traffic
    type: single_value
    model: snowplow_demo
    explore: visits
    measures: visits.blogpost_rate
    listen:
      date: visits.first_touch_date
    value_format: '0"%"'
    font_size: medium
  
  - name: bp_percentage_returning
    title: Percentage of Returning Visitors
    type: single_value
    model: snowplow_demo
    explore: visits
    measures: visits.returning_rate
    listen:
      date: visits.first_touch_date
    value_format: '0"%"'
    font_size: medium
  
  # Page views 
  
  - name: bp_views_over_time
    title: Page Views
    type: looker_area
    model: snowplow_demo
    explore: page_views
    dimensions: page_views.days_since_publishing
    measures: page_views.percent_of_total
    filters:
      page_views.blogpost: true
      page_views.blog_date_published_date: after 2014/08/06 # earliest data in demo
      page_views.blog_date_published_date: before 100 days ago # posted at least 100 days ago
      page_views.days_since_publishing: '[0, 100]'
    sorts: page_views.days_since_publishing
    interpolation: monotone
    show_null_points: true

  - name: bp_cumulative_views_over_time
    title: Page Views
    type: looker_area
    model: snowplow_demo
    explore: page_views
    dimensions: page_views.days_since_publishing
    measures: page_views.running_total
    filters:
      page_views.blogpost: true
      page_views.blog_date_published_date: after 2014/08/06 # earliest data in demo
      page_views.blog_date_published_date: before 100 days ago # posted at least 100 days ago
      page_views.days_since_publishing: '[0, 100]'
    sorts: page_views.days_since_publishing
    interpolation: monotone
    show_null_points: true
  
  
  #- name: blog_posts_published
  #  title: New Blogposts
  #  type: single_value
  #  model: snowplow_demo
  #  explore: page_views
  #  measures: [page_views.page_count]
  #  listen:
  #    date: page_views.blog_date_published_date
  #  filters:
  #    page_views.blogpost: true
  #  font_size: medium
  
  - name: blog_source
    title: Page Views
    type: looker_area
    model: snowplow_demo
    explore: page_views
    dimensions: page_views.first_touch_week
    pivots: page_views.referrer_medium
    measures: page_views.count
    listen:
      date: page_views.first_touch_date
    filters:
      page_views.blogpost: true
    sorts: page_views.first_touch_date
    show_null_points: true
    stacking: normal
    interpolation: monotone
  
  - name: blog_breadcrumb
    title: Page Views
    type: looker_area
    model: snowplow_demo
    explore: page_views
    dimensions: page_views.first_touch_week
    pivots: page_views.blog_breadcrumb
    measures: page_views.count
    listen:
      date: page_views.first_touch_date
    filters:
      page_views.blogpost: true
    sorts: page_views.first_touch_date
    show_null_points: true
    stacking: normal
    interpolation: monotone
  
  - name: bp_paths
    title: Next Section
    type: table
    model: snowplow_demo
    explore: visits
    dimensions: visits.path
    measures: [visits.count, visits.percent_of_total]
    filters:
      visits.blogpost: true
    sorts: visits.count desc

  - name: bp_top_posts
    title: Top Posts
    type: table
    model: snowplow_demo
    explore: page_views
    dimensions: page_views.page_title
    measures: [page_views.count, page_views.total_time_engaged_in_hours]
    filters:
      page_views.blogpost: true
    limit: 10
    sorts: page_views.count desc
  