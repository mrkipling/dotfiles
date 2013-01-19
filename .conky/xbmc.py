import jsonrpclib

def trunc(str, amt=20):
    return str[:amt].strip() + '...' if len(str) > amt + 2 else str

try:
    xbmc = jsonrpclib.Server("http://user:pass@xbmcurl:8080/jsonrpc")
    active_player = xbmc.Player.GetActivePlayers()
    playerid = active_player[0]['playerid']
    player_info = xbmc.Player.GetProperties(playerid=playerid, properties=['time', 'totaltime', 'position', 'percentage', 'repeat', 'shuffled'])
    percentage_progress = int(player_info['percentage'])

    if active_player[0]['type'] == 'video':
        print "\nXBMC ${color #333333}${hr 2}${color #ffffff}\n"

        currently_playing = xbmc.Player.GetItem(playerid = 1, properties = ['title', 'season', 'episode', 'duration', 'showtitle', 'fanart', 'tvshowid', 'plot', 'thumbnail', 'year'])['item']

        if currently_playing['type'] == 'movie':
            if currently_playing['year'] != 0:
                print "Name: ${alignr}%s" % trunc(currently_playing['label'])
                print "Year: ${alignr}%s" % currently_playing['year']

            else:
                print "Channel: ${alignr}%s" % trunc(currently_playing['label'])

        elif currently_playing['type'] == 'episode':
            print "Show: ${alignr}%s" % trunc(currently_playing['showtitle'])
            print "Episode: ${alignr}%s" % trunc(currently_playing['label'])
            print "Number: ${alignr}%sx%s" % (currently_playing['season'], ("%02d" % (currently_playing['season'],)))

        elif currently_playing['type'] == 'tvshow':
            print "TV: ${alignr}%s" % trunc(currently_playing['label'])

        if percentage_progress != 0:
            print "Progress: ${alignr}%s" % percentage_progress + '%'
            print "${execbar echo \"%s\"}" % percentage_progress

except:
    pass
