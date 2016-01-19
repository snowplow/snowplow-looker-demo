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

- view: events
  sql_table_name: demo.enriched_events
  fields:

  - dimension: br_name
    sql: ${TABLE}.br_name

  - dimension: br_viewheight
    type: int
    sql: ${TABLE}.br_viewheight

  - dimension: br_viewwidth
    type: int
    sql: ${TABLE}.br_viewwidth

  - dimension_group: collector_tstamp
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.collector_tstamp

  - dimension: doc_height
    type: int
    sql: ${TABLE}.doc_height

  - dimension: doc_width
    type: int
    sql: ${TABLE}.doc_width

  - dimension: domain_sessionidx
    type: number
    sql: ${TABLE}.domain_sessionidx

  - dimension: domain_userid
    sql: ${TABLE}.domain_userid

  - dimension: dvce_ismobile
    type: yesno
    sql: ${TABLE}.dvce_ismobile

  - dimension: dvce_screenheight
    type: int
    sql: ${TABLE}.dvce_screenheight

  - dimension: dvce_screenwidth
    type: int
    sql: ${TABLE}.dvce_screenwidth

  - dimension_group: dvce_created_tstamp
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.dvce_created_tstamp

  - dimension: dvce_type
    sql: ${TABLE}.dvce_type

  - dimension: event
    sql: ${TABLE}.event

  - dimension: event_id
    # hidden: true
    sql: ${TABLE}.event_id

  - dimension: geo_city
    sql: ${TABLE}.geo_city

  - dimension: geo_country
    sql: ${TABLE}.geo_country

  - dimension: geo_region
    sql: ${TABLE}.geo_region

  - dimension: geo_region_name
    sql: ${TABLE}.geo_region_name

  - dimension: link_click_event
    type: yesno
    sql: ${TABLE}.link_click_event

  - dimension: link_element_classes
    sql: ${TABLE}.link_element_classes

  - dimension: link_element_id
    sql: ${TABLE}.link_element_id

  - dimension: link_element_target
    sql: ${TABLE}.link_element_target

  - dimension: link_target_url
    sql: ${TABLE}.link_target_url

  - dimension: mkt_campaign
    sql: ${TABLE}.mkt_campaign

  - dimension: mkt_content
    sql: ${TABLE}.mkt_content

  - dimension: mkt_medium
    sql: ${TABLE}.mkt_medium

  - dimension: mkt_source
    sql: ${TABLE}.mkt_source

  - dimension: mkt_term
    sql: ${TABLE}.mkt_term

  - dimension: os_family
    sql: ${TABLE}.os_family

  - dimension: os_name
    sql: ${TABLE}.os_name

  - dimension: page_referrer
    sql: ${TABLE}.page_referrer

  - dimension: page_title
    sql: ${TABLE}.page_title

  - dimension: page_url
    sql: ${TABLE}.page_url

  - dimension: page_urlhost
    sql: ${TABLE}.page_urlhost

  - dimension: page_urlpath
    sql: ${TABLE}.page_urlpath

  - dimension: pp_xoffset_max
    type: int
    sql: ${TABLE}.pp_xoffset_max

  - dimension: pp_xoffset_min
    type: int
    sql: ${TABLE}.pp_xoffset_min

  - dimension: pp_yoffset_max
    type: int
    sql: ${TABLE}.pp_yoffset_max

  - dimension: pp_yoffset_min
    type: int
    sql: ${TABLE}.pp_yoffset_min

  - dimension: referrer
    sql: ${TABLE}.referrer

  - dimension: refr_medium
    sql: ${TABLE}.refr_medium

  - dimension: refr_source
    sql: ${TABLE}.refr_source

  - dimension: refr_term
    sql: ${TABLE}.refr_term

  - dimension: refr_urlhost
    sql: ${TABLE}.refr_urlhost

  - dimension: refr_urlpath
    sql: ${TABLE}.refr_urlpath

  - dimension: sign_up_company
    sql: ${TABLE}.sign_up_company

  - dimension: sign_up_email
    sql: ${TABLE}.sign_up_email

  - dimension: sign_up_event
    type: yesno
    sql: ${TABLE}.sign_up_event

  - dimension: sign_up_events_per_month
    sql: ${TABLE}.sign_up_events_per_month

  - dimension: sign_up_name
    sql: ${TABLE}.sign_up_name

  - dimension: sign_up_service_type
    sql: ${TABLE}.sign_up_service_type

  - dimension: trial_company
    sql: ${TABLE}.trial_company

  - dimension: trial_email
    sql: ${TABLE}.trial_email

  - dimension: trial_event
    type: yesno
    sql: ${TABLE}.trial_event

  - dimension: trial_events_per_month
    sql: ${TABLE}.trial_events_per_month

  - dimension: trial_name
    sql: ${TABLE}.trial_name

  - dimension: w3_author
    sql: ${TABLE}.w3_author

  - dimension: w3_breadcrumb
    sql: ${TABLE}.w3_breadcrumb

  - dimension: w3_chrome_first_paint
    type: number
    sql: ${TABLE}.w3_chrome_first_paint

  - dimension: w3_connect_end
    type: number
    sql: ${TABLE}.w3_connect_end

  - dimension: w3_connect_start
    type: number
    sql: ${TABLE}.w3_connect_start

  - dimension: w3_content_event
    type: yesno
    sql: ${TABLE}.w3_content_event

  - dimension_group: w3_date_created
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.w3_date_created

  - dimension_group: w3_date_modified
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.w3_date_modified

  - dimension_group: w3_date_published
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.w3_date_published

  - dimension: w3_dom_complete
    type: number
    sql: ${TABLE}.w3_dom_complete

  - dimension: w3_dom_content_loaded_event_end
    type: number
    sql: ${TABLE}.w3_dom_content_loaded_event_end

  - dimension: w3_dom_content_loaded_event_start
    type: number
    sql: ${TABLE}.w3_dom_content_loaded_event_start

  - dimension: w3_dom_interactive
    type: number
    sql: ${TABLE}.w3_dom_interactive

  - dimension: w3_dom_loading
    type: number
    sql: ${TABLE}.w3_dom_loading

  - dimension: w3_domain_lookup_end
    type: number
    sql: ${TABLE}.w3_domain_lookup_end

  - dimension: w3_domain_lookup_start
    type: number
    sql: ${TABLE}.w3_domain_lookup_start

  - dimension: w3_fetch_start
    type: number
    sql: ${TABLE}.w3_fetch_start

  - dimension: w3_genre
    sql: ${TABLE}.w3_genre

  - dimension: w3_in_language
    sql: ${TABLE}.w3_in_language

  - dimension: w3_keywords
    sql: ${TABLE}.w3_keywords

  - dimension: w3_load_event_end
    type: number
    sql: ${TABLE}.w3_load_event_end

  - dimension: w3_load_event_start
    type: number
    sql: ${TABLE}.w3_load_event_start

  - dimension: w3_ms_first_paint
    type: number
    sql: ${TABLE}.w3_ms_first_paint

  - dimension: w3_navigation_start
    type: number
    sql: ${TABLE}.w3_navigation_start

  - dimension: w3_performance_event
    type: yesno
    sql: ${TABLE}.w3_performance_event

  - dimension: w3_redirect_end
    type: number
    sql: ${TABLE}.w3_redirect_end

  - dimension: w3_redirect_start
    type: number
    sql: ${TABLE}.w3_redirect_start

  - dimension: w3_request_start
    type: number
    sql: ${TABLE}.w3_request_start

  - dimension: w3_response_end
    type: number
    sql: ${TABLE}.w3_response_end

  - dimension: w3_response_start
    type: number
    sql: ${TABLE}.w3_response_start

  - dimension: w3_secure_connection_start
    type: number
    sql: ${TABLE}.w3_secure_connection_start

  - dimension: w3_unload_event_end
    type: number
    sql: ${TABLE}.w3_unload_event_end

  - dimension: w3_unload_event_start
    type: number
    sql: ${TABLE}.w3_unload_event_start

  - measure: count
    type: count
    drill_fields: detail*


  # ----- Sets of fields for drilling ------
  sets:
    event_detail:
    - dvce_created_tstamp_time
    - event
    - page_urlhost
    - page_urlpath
