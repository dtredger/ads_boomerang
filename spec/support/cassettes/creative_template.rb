# creative_template
# - creative_template_id 1 is Beeswax' default IMG template (predefined)

{
  :creative_template_id=>1,
  :creative_template_name=>"Image template",
  :creative_template_content=>"<a href='{{CLICK_URL}}' target='_blank'><img src='{{CUSTOM:IMAGE_NAME:FILE}}' alt='tap here' width='{{WIDTH}}' height='{{HEIGHT}}'></a><img src='{{IMPRESSION_URL}}' width='0' height='0'>{{#ADDITIONAL_PIXELS:0:10<img src='{{CUSTOM:PIXEL_URL:URL}}' width='0' height='0'>/}}{{#ADDITIONAL_SCRIPTS:0:10<script type='text/javascript' src='{{CUSTOM:SCRIPT_URL:URL}}'></script>/}}",
  :rendering_key=>"IMAGE",
  :global=>true,
  :creative_type=>0,
  :creative_attributes=>{
    :technical=>{
      :tag_type=>[2]
    }
  },
  :macro_names=>{
    :IMAGE_NAME=>"STRING",
    :ADDITIONAL_PIXELS=>{
      :min=>"0",
      :max=>"10",
      :fields=>{
        :PIXEL_URL=>"URL"
      }
    },
    :ADDITIONAL_SCRIPTS=>{
      :min=>"0",
      :max=>"10",
      :fields=>{
        :SCRIPT_URL=>"URL"
      }
    }
  },
  :active=>true,
  :alternative_id=>nil,
  :account_id=>1,
  :global_account_id=>-1,
  :click_required=>true,
  :buzz_key=>"stingersbx"
}
