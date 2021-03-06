#!/usr/bin/env python2
# -*- coding: utf-8 -*-

import pygtk
pygtk.require('2.0')
import gtk
import os

class DoTheLogOut:

	# Cancel/exit
	def delete_event(self, widget, event, data=None):
		gtk.main_quit()
		return False
		
	# Logout
	def logout(self, widget):
		os.system("openbox --exit")
		os.system("killall X")
	
	# Reboot
	def reboot(self, widget):
		os.system("sudo shutdown -r now && openbox --exit")
	
	# Shutdown
	def shutdown(self, widget):
		os.system("sudo shutdown -h now && openbox --exit")
	
	# Suspend
	def suspend(self, widget):
		os.system("sudo pm-suspend")
	
	def __init__(self):
		# Create a new window
		self.window = gtk.Window(gtk.WINDOW_TOPLEVEL)
		self.window.set_title("Exit? Choose an option:")
		self.window.set_resizable(False)
		self.window.set_position(1)
		self.window.connect("delete_event", self.delete_event)
		self.window.set_border_width(20)
		
		# Create an accelgroup and add it to the window
		accel_group = gtk.AccelGroup()
		self.window.add_accel_group(accel_group)
		
		# Create a box to pack widgets into
		self.box1 = gtk.HBox(False, 0)
		self.window.add(self.box1)
		
		# Create cancel button
		self.button1 = gtk.Button("Cancel")
		self.button1.set_border_width(10)
		self.button1.connect("clicked", self.delete_event, "closed")
		self.box1.pack_start(self.button1, True, True, 0)
		self.button1.add_accelerator("clicked", accel_group,
				gtk.gdk.keyval_from_name('Escape'), 0, 0)
		self.button1.add_accelerator("clicked", accel_group,
				gtk.gdk.keyval_from_name('c'), 0, 0)
		self.button1.show()
		
		# Create logout button
		self.button2 = gtk.Button("Logout")
		self.button2.set_border_width(10)
		self.button2.connect("clicked", self.logout)
		self.box1.pack_start(self.button2, True, True, 0)
		self.button2.add_accelerator("clicked", accel_group,
				gtk.gdk.keyval_from_name('l'), 0, 0)
		self.button2.show()
		
		# Create reboot button
		self.button3 = gtk.Button("Reboot")
		self.button3.set_border_width(10)
		self.button3.connect("clicked", self.reboot)
		self.box1.pack_start(self.button3, True, True, 0)
		self.button3.add_accelerator("clicked", accel_group,
				gtk.gdk.keyval_from_name('r'), 0, 0)
		self.button3.show()
		
		# Create shutdown button
		self.button4 = gtk.Button("Shutdown")
		self.button4.set_border_width(10)
		self.button4.connect("clicked", self.shutdown)
		self.box1.pack_start(self.button4, True, True, 0)
		self.button4.add_accelerator("clicked", accel_group,
				gtk.gdk.keyval_from_name('s'), 0, 0)
		self.button4.show()
		
		# Create suspend button
		self.button5 = gtk.Button("Suspend")
		self.button5.set_border_width(10)
		self.button5.connect("clicked", self.suspend)
		self.box1.pack_start(self.button5, True, True, 0)
		self.button5.add_accelerator("clicked", accel_group,
				gtk.gdk.keyval_from_name('h'), 0, 0)
		self.button5.show()
		
		self.box1.show()
		self.window.show()
	
def main():
	gtk.main()
	
if __name__ == "__main__":
	run_it = DoTheLogOut()
main()
