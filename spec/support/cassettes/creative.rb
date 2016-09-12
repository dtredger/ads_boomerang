creative=Beeswax.request(:get, "/rest/creative/24296")

response = {
	:success => true,
	:payload => [ {
		:creative_id => 24296,
		:advertiser_id => 38526,
		:creative_type => 0,
		:creative_template_id => 1,
		:creative_status_id => 1,
		:creative_rule_id => nil,
		:width => 300,
		:height => 250,
		:sizeless => false,
		:secure => true,
		:click_url => "http://test.com",
		:creative_name => "test",
		:creative_attributes => {
			:advertiser => {
				:advertiser_category => [ "IAB19_34" ],
				:advertiser_domain => [ "http://advertiser1.com" ],
				:landing_page_url => [ "http://advertiser1.com" ]
			},
			:mobile => {
				mraid_playable: [false]
			},
			:technical => {
				:banner_mime => [ "image/png" ],
				:tag_type => [ 2 ]
			}
		},
		:creative_approvals => {
			:pending => [ 1 ]
		},
		:creative_assets => [ 7826 ],
		:creative_addons => [],
		:pixels => [],
		:scripts => [],
		:creative_content => {
			:IMAGE_NAME => "{{MEDIA_HOST}}/stingersbx/94/38526/7826_300x250.png"
		},
		:creative_content_munge => "<a href='{{CLICK_URL}}' target='_blank'><img src='{{MEDIA_HOST}}/stingersbx/94/38526/7826_300x250.png' alt='tap here' width='{{WIDTH}}' height='{{HEIGHT}}'></a><img src='{{IMPRESSION_URL}}' width='0' height='0'>",
		:preview_token => "Wm4JC4kWIFYPnttqZwXNoepc3WzG5g31C7Lfc6bU",
		:creative_thumbnail_url => "/stingersbx/94/38526/thumb/7826_300x250_thumb.jpg",
		:start_date => nil,
		:end_date => nil,
		:frequency_cap => [],
		:push_status => 0,
		:push_update => true,
		:account_id => 94,
		:create_date => "2016-09-07 19:07:19",
		:update_date => "2016-09-07 19:07:19",
		:alternative_id => nil,
		:notes => nil,
		:active => true,
		:buzz_key => "stingersbx"
	}]
}