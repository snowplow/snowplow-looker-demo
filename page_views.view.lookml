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

- view: page_views
  sql_table_name: demo.page_views
  fields:
  
  # DIMENSIONS #
  
  # Visiter identifier
  
  - dimension: visitor_id
    sql: ${TABLE}.domain_userid
  
  # Visit identifiers (custom server-side sessionization)
  
  - dimension: visit_index
    type: int
    sql: ${TABLE}.visit_index
  
  - dimension: visit_page_view_rank
    type: int
    sql: ${TABLE}.visit_page_view_rank

  # Page view identifier (across all visits)
  
  - dimension: page_view_rank
    type: int
    sql: ${TABLE}.page_view_rank
  
  # Page identifiers
  
  - dimension: page
    sql: ${TABLE}.page_urlhost || ${TABLE}.page_urlpath
  
  - dimension: page_host
    sql: ${TABLE}.page_urlhost
  
  - dimension: page_path
    sql: ${TABLE}.page_urlpath
  
  # Page details
  
  - dimension: page_title
    sql: ${TABLE}.page_title
  
  - dimension: section
    sql_case:
      homepage: ${TABLE}.section = 'homepage'
      analytics: ${TABLE}.section = 'analytics'
      blog: ${TABLE}.section = 'blog'
      product: ${TABLE}.section = 'product'
      technology: ${TABLE}.section = 'technology'
      pricing: ${TABLE}.section = 'pricing'
      else: other
  
  - dimension: blogpost
    type: yesno
    sql: ${TABLE}.blogpost
  
  - dimension: blog_breadcrumb
    sql: ${TABLE}.blog_breadcrumb
  
  - dimension: blog_author
    sql: ${TABLE}.blog_author
  
  - dimension: blog_date_published
    type: time
    timeframes: [date]
    sql: ${TABLE}.blog_date_published
  
  - dimension: blog_keywords
    sql: ${TABLE}.blog_keywords
  
  # Time
  
  - dimension: first_touch
    type: time
    timeframes: [time, hour, date, week, month, day_of_week]
    sql: ${TABLE}.first_touch_tstamp
  
  # TEST
  
  - dimension: days_since_publishing
    type: int
    sql: EXTRACT (DAYS FROM (${TABLE}.first_touch_tstamp - ${TABLE}.blog_date_published))
  
  # Engagement
  
  - dimension: time_engaged
    type: int
    sql: ${TABLE}.time_engaged_in_seconds
  
  # Referrer details
  
  - dimension: referrer_medium
    sql_case:
      internal: ${TABLE}.refr_medium = 'internal'
      direct: ${TABLE}.refr_medium = 'direct'
      search: ${TABLE}.refr_medium = 'search'
      social: ${TABLE}.refr_medium = 'social'
      # other: ${TABLE}.refr_medium = 'other'
      # email: ${TABLE}.refr_medium = 'email'
      else: 'other'
  
  # MEASURES #
  
  # Basic counts
  
  - measure: count
    type: count
  
  - measure: percent_of_total
    type: percent_of_total
    sql: ${count}

  - measure: running_total
    type: running_total
    sql: ${percent_of_total} # ${count}
  
  - measure: page_count
    type: count_distinct
    sql: ${page_path}
  
  - measure: visit_count
    type: count_distinct
    sql: ${visitor_id} || '-' || ${visit_index}
  
  - measure: visitor_count
    type: count_distinct
    sql: ${visitor_id}
  
  # Time engaged
  
  - measure: total_time_engaged
    type: sum
    sql: ${time_engaged}
  
  - measure: total_time_engaged_in_hours
    type: number
    decimals: 2
    sql: ${total_time_engaged}/3600
  
  - measure: time_engaged_per_visit
    type: number
    decimals: 0
    sql: ${total_time_engaged}/NULLIF(${visit_count}, 0)::REAL
    value_format: '#,##0"s"'
  