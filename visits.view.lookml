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
    hidden: true
  
  # Visit identifier
  
  - dimension: visit_id
    sql: ${TABLE}.visit_id
    hidden: true
  
  - dimension: visit
    type: int
    sql: ${TABLE}.visit_index
  
  # New visitor
  
  - dimension: new_visitor
    type: yesno
    sql: ${visit} = 1
  
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
    sql: ${TABLE}.section_1
  
  - dimension: landing_page_is_blogpost
    type: yesno
    sql: ${TABLE}.landing_page_blogpost
  
  - dimension: landing_page_blog_breadcrumb
    sql: ${TABLE}.landing_blog_breadcrumb
  
  # Engagement
  
  - dimension: total_page_views
    type: int
    sql: ${TABLE}.page_views
    hidden: true
  
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
    sql: ${TABLE}.refr_medium
  
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
  
  - measure: visits
    type: count_distinct
    sql: ${visit_id}
    
  - measure: visitors
    type: count_distinct
    sql: ${visitor_id}
  
  # New versus returning
  
  - measure: new_visits
    type: count_distinct
    sql: ${visit_id}
    filter:
      new_visitor: yes
    hidden: true
  
  - measure: returning_visits
    type: int
    sql: ${visits} - ${new_visits}
    hidden: true
  
  - measure: new_visits_ratio
    type: number
    decimals: 0
    sql: 100*${new_visits}/NULLIF(${visits},0)::REAL
  
  - measure: returning_visits_ratio
    type: number
    decimals: 0
    sql: 100*${returning_visits}/NULLIF(${visits},0)::REAL
  