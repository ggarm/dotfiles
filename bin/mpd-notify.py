#!/usr/bin/env python
import mpd
import os
import time
import sys
import re
import pynotify

home = os.path.expanduser('~')
success = False
while success == False:
	try:
		client = mpd.MPDClient()
		client.connect("localhost", 6600)
		success = True
	except:
		time.sleep(5)
		success = False
try:
	last_song = client.currentsong()['file']
	last_status = client.status()['state']
	artist = client.currentsong()['artist']
	album = client.currentsong()['album']
	title = client.currentsong()['title']
	if os.path.exists('%s/.covers/%s-%s.jpg'%(home,artist,album)):
		os.popen('notify-send -i "%s/.covers/%s-%s.jpg" "%s" "%s"'%(home,artist,album,artist,title))
	else:
		os.popen('notify-send -i sonata "%s" "%s"'%(artist,title))
except:
	pass
	last_song = ""
	last_status = ""
while True:
	try:
	   currentsong = client.currentsong()['file']
	   status = client.status()['state']
	except:
	   currentsong = ""
	   status = last_status
	if last_status != status:
		try:
			if status == "play":
				comment = "media-playback-start" + " MPD Playing"
			elif status == "pause":
				comment = "media-playback-pause" + " MPD Paused"
			else:
				comment = "media-playback-stop" + " MPD Stopped"
			os.popen('notify-send -u critical -t 10 -i %s'%comment)
			if status == "play":
				for file_type in ('jpg','png','bmp','gif'):
					if os.path.exists('%s/.covers/%s-%s.%s'%(home,artist,album,file_type)):
						os.popen('notify-send -i "%s/.covers/%s-%s.%s" "%s" "%s"'%(home,artist,album,file_type,artist,title))
						break

				else:
					os.popen('notify-send -i sonata "%s" "%s"'%(artist,title))
			last_status = client.status()['state']
		except:
			pass
	if last_song != currentsong:
		try:
			artist = client.currentsong()['artist']
			album = client.currentsong()['album']
			title = client.currentsong()['title']
			if os.path.exists('%s/.covers/%s-%s.jpg'%(home,artist,album)):
				os.popen('notify-send -i "%s/.covers/%s-%s.jpg" "%s" "%s"'%(home,artist,album,artist,title))
			else:
				os.popen('notify-send -i sonata "%s" "%s"'%(artist,title))
			last_song = client.currentsong()['file']
		except:
			pass

	time.sleep(1)
