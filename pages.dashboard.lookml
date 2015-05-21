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

- dashboard: pages
  title: Snowplow Demo – Pages
  layout: grid
  rows:
    #- elements: [total_page_views, engaged_page_views, engaged_visitors, total_time_engaged]
    #  height: 250
    - elements: [page_views_per_section, time_engaged]
      height: 500
    #- elements: [page_views_per_week, time_engaged_per_week]
    #  height: 500
    #- elements: [top_blog_posts, top_pages]
    #  height: 500
  
  filters:
  
  - name: date
    title: Date
    type: date_filter
    default_value: 26 Weeks
  
  elements:

  - name: page_views_per_section
    title: Page Views
    type: looker_area
    model: snowplow_demo
    explore: page_views
    dimensions: [page_views.first_touch_week]
    pivots: [page_views.section]
    measures: [page_views.count]
    listen:
      date: page_views.first_touch_week
    sorts: [page_views.first_touch_week]
    show_null_points: true
    stacking: normal
    show_value_labels: false
    show_view_names: true
    x_axis_gridlines: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    x_axis_scale: auto
    point_style: none
    interpolation: linear

  - name: time_engaged
    title: Time Engaged
    type: looker_area
    model: snowplow_demo
    explore: page_views
    dimensions: [page_views.first_touch_week]
    pivots: [page_views.section]
    measures: [page_views.total_time_engaged]
    listen:
      date: page_views.first_touch_date
    sorts: [page_views.first_touch_date]
    show_null_points: true
    stacking: normal
    show_value_labels: false
    show_view_names: true
    x_axis_gridlines: false
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    x_axis_scale: auto
    point_style: none
    interpolation: linear