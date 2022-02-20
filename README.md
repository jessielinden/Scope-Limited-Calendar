#  Scope-Limited Calendar

Hi, my name is Jessie. I am a new indie developer and have finally achieved something I've failed at creating many times, so I wanted to share it. 

The project name describes what I wanted, but not what is actually going on. I wanted a SwiftUI custom calendar that only showed specific months. I utilized some extremely helpful code for the base of the calendar, written by Majid Jabrayilov, and expanded on by Abdullah Alahdal (both linked below), but I couldn't find any resource that showed how to limit the scope of the calendar. I believe I have come to understand that, at least in their approach, you can't. You're going to get access to a certain scope of the current calendar, and it may have dates in the past or the future that you're not interested in showing to the user. 

The solution? Limit what the user can see. In hindsight, it's simple, but I went deep into Calendar/Date/DateComponents land until I settled on this approach. For some reason, I thought I'd try and limit the calendar, not the UI. Lesson learned. But now, I have exactly what I want, which is a monthly calendar that is moved through its pages using left and right buttons (as opposed to a tab or scroll view), and the first and last month of the visible calendar are the bounds of an interval that I specify.

I hope if you faced similar confusion about calendars, this may be of use to you. I used XCode 13.2.1.

Majid's article: 
https://gist.github.com/mecid/f8859ea4bdbd02cf5d440d58e936faec/9169b0293f709bb1f560de2ca8184ea903fd5116

Abdullah's expansion:
https://gist.github.com/alahdal/deb37df908be07d2a64456229276665e
