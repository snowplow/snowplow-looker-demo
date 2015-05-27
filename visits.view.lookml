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

- view: visits
  sql_table_name: derived.visits
  fields:
  
  # DIMENSIONS #
  
  # Visitor identifier
  
  - dimension: visitor_id
    sql: ${TABLE}.domain_userid
    hidden: true # Used for counting
  
  # Visit identifier
  
  - dimension: visit_id
    sql: ${TABLE}.visit_id
    hidden: true # Used for counting
  
  - dimension: visit
    type: int
    sql: ${TABLE}.visit_index
  
  # New visitor
  
  - dimension: new_visitor
    type: yesno
    sql: ${visit} = 1
  
  - dimension: new_versus_returning
    sql_case:
      new: ${TABLE}.visit_index = 1
      returning: ${TABLE}.visit_index > 1
    html: |
      <a href='../../dashboards/snowplow_demo/visits?new_versus_returning={{value}}' target='_new'>{{value}}</a>
      <a href='../../explore/snowplow_demo/visits?fields=visits.timestamp_week,visits.total_visits&f[visits.new_versus_returning]={{value}}&show=vis,data&vis=%7B"type":"looker_area","show_null_points":true,"stacking":"normal","interpolation":"monotone"%7D' target='_new'>
      <img src='/images/qr-graph-line@2x.png' height=20 width=20></a>
    hidden: true
  
  # Landing page
  
  - dimension: landing_page
    sql: ${TABLE}.landing_page_urlhost || ${TABLE}.landing_page_urlpath
  
  - dimension: landing_page_host
    sql: ${TABLE}.landing_page_urlhost
    hidden: true
  
  - dimension: landing_page_path
    sql: ${TABLE}.landing_page_urlpath
  
  # Landing page details
  
  - dimension: landing_page_title
    sql: ${TABLE}.landing_page_title
  
  - dimension: landing_page_section
    sql_case:
      homepage: ${TABLE}.section_1 = 'homepage'
      blog: ${TABLE}.section_1 = 'blog'
      analytics: ${TABLE}.section_1 = 'analytics'
      technology: ${TABLE}.section_1 = 'technology'
      product: ${TABLE}.section_1 = 'product'
      pricing: ${TABLE}.section_1 = 'pricing'
      other: ${TABLE}.section_1 = 'other'
    html: |
      <a href='../../dashboards/snowplow_demo/visits?landing_page_section={{value}}' target='_new'>{{value}}</a>
      <a href='../../explore/snowplow_demo/visits?fields=visits.timestamp_week,visits.total_visits&f[visits.landing_page_section]={{value}}&show=vis,data&vis=%7B"type":"looker_area","show_null_points":true,"stacking":"normal","interpolation":"monotone"%7D' target='_new'>
      <img src='/images/qr-graph-line@2x.png' height=20 width=20></a>
  
  - dimension: landing_page_is_blogpost
    type: yesno
    sql: ${TABLE}.landing_page_blogpost
  
  - dimension: landing_page_blog_breadcrumb
    sql: ${TABLE}.landing_blog_breadcrumb
  
  # Engagement
  
  - dimension: page_views
    type: int
    sql: ${TABLE}.page_views
    hidden: true
  
  - dimension: page_views_tier
    type: tier
    tiers: [1,2,3,4,5,10,20,50]
    sql: ${page_views}
  
  - dimension: device_timestamp
    type: time
    timeframes: [time_of_day, hour_of_day, day_of_week] # Relative
    sql: ${TABLE}.min_dvce_tstamp
  
  - dimension: max_dvce_tstamp
    sql: ${TABLE}.max_dvce_tstamp
    hidden: true
  
  - dimension: timestamp
    type: time
    timeframes: [time, hour, date, week, month]
    sql: ${TABLE}.first_touch_tstamp
  
  - dimension: last_touch_tstamp
    type: time
    timeframes: time
    sql: ${TABLE}.last_touch_tstamp
    hidden: true
  
  - dimension: time_engaged
    type: int
    sql: ${TABLE}.time_engaged_in_seconds
    hidden: true
  
  # Source
  
  - dimension: referrer
    sql: ${TABLE}.refr_urlhost || ${TABLE}.refr_urlpath
  
  - dimension: referrer_host
    sql: ${TABLE}.refr_urlhost
  
  - dimension: referrer_path
    sql: ${TABLE}.refr_urlpath
    hidden: true
  
  - dimension: referrer_medium
    sql_case:
      internal: ${TABLE}.refr_medium = 'internal'
      direct: ${TABLE}.refr_medium = 'direct'
      search: ${TABLE}.refr_medium = 'search'
      social: ${TABLE}.refr_medium = 'social'
      email: ${TABLE}.refr_medium = 'email'
      other: ${TABLE}.refr_medium = 'other'
    html: |
      <a href='../../dashboards/snowplow_demo/visits?referrer_medium={{value}}' target='_new'>{{value}}</a>
      <a href='../../explore/snowplow_demo/visits?fields=visits.timestamp_week,visits.total_visits&f[visits.referrer_medium]={{value}}&show=vis,data&vis=%7B"type":"looker_area","show_null_points":true,"stacking":"normal","interpolation":"monotone"%7D' target='_new'>
      <img src='/images/qr-graph-line@2x.png' height=20 width=20></a>
  
  - dimension: referrer_source
    sql: ${TABLE}.refr_source
  
  - dimension: referrer_term
    sql: ${TABLE}.refr_term
    hidden: true
  
  - dimension: marketing_medium
    sql: ${TABLE}.mkt_medium
    hidden: true
  
  - dimension: marketing_source
    sql: ${TABLE}.mkt_source
    hidden: true
  
  - dimension: marketing_term
    sql: ${TABLE}.mkt_term
    hidden: true
  
  - dimension: marketing_content
    sql: ${TABLE}.mkt_content
    hidden: true
  
  - dimension: marketing_campaign
    sql: ${TABLE}.mkt_campaign
    hidden: true
  
  # Location
  
  - dimension: country
    sql: ${TABLE}.geo_country
  
  - dimension: top_countries
    sql_case:
      US: ${TABLE}.geo_country = 'United States of America'
      India: ${TABLE}.geo_country = 'India'
      UK: ${TABLE}.geo_country = 'United Kingdom'
      Germany: ${TABLE}.geo_country = 'Germany'
      Australia: ${TABLE}.geo_country = 'Australia'
      else: 'other'
    html: |
      <a href='../../dashboards/snowplow_demo/visits?top_countries={{value}}' target='_new'>{{value}}</a>
      <a href='../../explore/snowplow_demo/visits?fields=visits.timestamp_week,visits.total_visits&f[visits.top_countries]={{value}}&show=vis,data&vis=%7B"type":"looker_area","show_null_points":true,"stacking":"normal","interpolation":"monotone"%7D' target='_new'>
      <img src='/images/qr-graph-line@2x.png' height=20 width=20></a>
    hidden: true
  
  - dimension: country_code_2
    sql: ${TABLE}.geo_country_code_2_characters
    hidden: true
  
  - dimension: country_code_3
    sql: ${TABLE}.geo_country_code_3_characters
    hidden: true
  
  - dimension: region
    sql: ${TABLE}.geo_region
    hidden: true
  
  - dimension: region_name
    sql: ${TABLE}.geo_region_name
    hidden: true
  
  - dimension: city
    sql: ${TABLE}.geo_city
  
  # Paths
  
  - dimension: total_sections
    type: int
    sql: ${TABLE}.max_section_count
    hidden: true
  
  - dimension: section_1
    sql: ${TABLE}.section_1
    hidden: true
  
  - dimension: section_2
    sql: ${TABLE}.section_2
    hidden: true
  
  - dimension: section_3
    sql: ${TABLE}.section_3
    hidden: true
  
  - dimension: section_4
    sql: ${TABLE}.section_4
    hidden: true
  
  - dimension: section_5
    sql: ${TABLE}.section_5
    hidden: true
  
  - dimension: path_2
    sql: ${TABLE}.path_2
    hidden: true
  
  - dimension: path_3
    sql: ${TABLE}.path_3
    hidden: true
  
  - dimension: path_4
    sql: ${TABLE}.path_4
    hidden: true
  
  - dimension: path_5
    sql: ${TABLE}.path_5
    hidden: true
  
  # MEASURES #
  
  # Basic measures
  
  - measure: total_visits
    type: count_distinct
    sql: ${visit_id}
    
  - measure: total_visitors
    type: count_distinct
    sql: ${visitor_id}
  
  # Percentage
  
  - measure: percentage_of_total_visits
    type: percent_of_total
    sql: ${total_visits}
  
  # New versus returning
  
  - measure: new_visits
    type: count_distinct
    sql: ${visit_id}
    filter:
      new_visitor: yes
    hidden: true
  
  - measure: returning_visits
    type: int
    sql: ${total_visits} - ${new_visits}
    hidden: true
  
  - measure: new_visits_ratio
    type: number
    decimals: 0
    sql: 100*${new_visits}/NULLIF(${total_visits}, 0)::REAL
  
  - measure: returning_visits_ratio
    type: number
    decimals: 0
    sql: 100*${returning_visits}/NULLIF(${total_visits}, 0)::REAL
  
  # Page views
  
  - measure: total_page_views
    type: sum
    sql: ${page_views}
  
  - measure: page_views_per_visit
    type: number
    decimals: 2
    sql: ${total_page_views}/NULLIF(${total_visits}, 0)::REAL
  
  # Time engaged
  
  - measure: total_time_engaged
    type: sum
    sql: ${time_engaged}
  
  - measure: total_time_engaged_in_hours
    type: sum
    sql: ${time_engaged}/3600
  
  - measure: time_engaged_per_visit
    type: number
    decimals: 0
    sql: ${total_time_engaged}/NULLIF(${total_visits}, 0)::REAL
    