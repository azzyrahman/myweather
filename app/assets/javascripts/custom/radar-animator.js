
function AnimatorWrapper() {
      
        this.animator1 = 0;
        this.rframes = [];

        this.upperType = 'wzcountry';
        this.upperCode = 'aus';
        this.currentType = 'wzcountry';
        this.currentCode = 'aus';
        this.previousType = 'wzcountry';
        this.previousCode = 'aus';
        
        var that = this;
      
        this.populateAnim = function(data) {
      
            var layers = [];
            this.rframes = [];
            this.animator1 = 0;

            jQuery.each(data.frames, function(i, obj){
              that.rframes.push(new AnimatorFrame(obj.image, new Date(obj.timestamp), obj.timestamp_string));
            });
          
            $('#anim_map').remove();
            $('#anim_locations').remove();          
            
            layers[0] = new AnimatorLayer('map','Map',true,true,[new AnimatorFrame('http://data.weatherzone.com.au/maplayers/wz/terrain/terrain_'+this.currentType+'_'+this.currentCode+'_640x480.jpg')]);
            layers[1] = new AnimatorLayer('radar','Radar',true,true,this.rframes);
            layers[2] = new AnimatorLayer('locations','Locations',true,true,[new AnimatorFrame('http://data.weatherzone.com.au/maplayers/wz/locations/locations_'+this.currentType+'_'+this.currentCode+'_640x480.gif')]);

            this.animator1 = new Animator('anim', layers, 1);
            this.animator1.initialise();
            this.animator1.stop();
            this.animator1.start();
          
            $('#anchormap_'+this.currentType+'_'+this.currentCode).show();
            //window.location="?loaded=true";

        };
              
        this.zoomLocationAnchor = function(typeTo,codeTo,upT,upC) {

          $('#anim_startstop').unbind('click');
          if (this.animator1) this.animator1.stop();
          this.animator1 = 0;

          $('#anim_zoomout').unbind('click'); 
          $('#anim_zoomout').click(function () {that.zoomLocationAnchor(upT,upC,'wzcountry','aus');return false;});
          
          $('#anchormap_'+this.currentType+'_'+this.currentCode).hide();
          
          this.previousType = this.currentType;
          this.previousCode = this.currentCode;
          this.currentType = typeTo;
          this.currentCode = codeTo;
          this.upperType = upT;
          this.upperCode = upC;
          
          jQuery.ajax({
            url: "http://data.weatherzone.com.au/json/animator/?lt="+this.currentType+"&lc="+this.currentCode+"&type=radar&frames=4&callback=?",
            dataType: 'jsonp',
            jsonpCallback: 'cbrad'+this.currentCode,
            success: function(data){that.populateAnim(data)},
            cache: false
          });

        }
        
        this.reload = function () {
          
          $('#anim_startstop').unbind('click');
          if (this.animator1) this.animator1.stop();
          this.animator1 = 0;
        
          jQuery.ajax({
            url: "http://data.weatherzone.com.au/json/animator/?lt="+this.currentType+"&lc="+this.currentCode+"&type=radar&frames=4&callback=?",
            dataType: 'jsonp',
            jsonpCallback: 'cbrad'+this.currentCode,
            success: function(data){that.populateAnim(data)},
            cache: false
          });          
          
        }
        
    };  
      
      var aw;
    
    $(document).ready(function() {

      aw = new AnimatorWrapper();
                      
      aw.reload();
      window.setInterval(function(){aw.reload()},300000);

    });
      