var METRO_AUTO_REINIT, METRO_LOCALE, METRO_WEEK_START, METRO_DIALOG = !1;
(function(c) {
	c.Metro = function(a) {
		c.extend({}, a)
	};
	c.Metro.getDeviceSize = function() {
		return {
			width: 0 < window.innerWidth ? window.innerWidth : screen.width,
			height: 0 < window.innerHeight ? window.innerHeight : screen.height
		}
	}
})(jQuery);
$(function() {
	$("html").on("click", function(c) {
		$(".dropdown-menu").each(function(a, b) {
			$(b).hasClass("keep-open") || "block" != $(b).css("display") || $(b).hide()
		})
	})
});
$(function() {
	$(window).on("resize", function() {
		if (METRO_DIALOG) {
			var c = ($(window).height() - METRO_DIALOG.outerHeight()) / 2,
				a = ($(window).width() - METRO_DIALOG.outerWidth()) / 2;
			METRO_DIALOG.css({
				top: c,
				left: a
			})
		}
	})
});
(function(c) {
	c.Metro.currentLocale = "en";
	c.Metro.currentLocale = void 0 != METRO_LOCALE ? METRO_LOCALE : "en";
	c.Metro.Locale = {
		en: {
			months: "January February March April May June July August September October November December Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec".split(" "),
			days: "Sunday Monday Tuesday Wednesday Thursday Friday Saturday Su Mo Tu We Th Fr Sa".split(" "),
			buttons: "Today Clear Cancel Help Prior Next Finish".split(" ")
		},
		fr: {
			months: "Janvier F\u00e9vrier Mars Avril Mai Juin Juillet Ao\u00fbt Septembre Octobre Novembre D\u00e9cembre Jan F\u00e9v Mars Avr Mai Juin Juil Ao\u00fbt Sept Oct Nov D\u00e9c".split(" "),
			days: "Dimanche Lundi Mardi Mercredi Jeudi Vendredi Samedi Di Lu Ma Me Je Ve Sa".split(" "),
			buttons: "Aujourd'hui Effacer Annuler Aide Pr\u00e9cedent Suivant Fin".split(" ")
		},
		nl: {
			months: "Januari Februari Maart April Mei Juni Juli Augustus September Oktober November December Jan Feb Mrt Apr Mei Jun Jul Aug Sep Okt Nov Dec".split(" "),
			days: "Zondag Maandag Dinsdag Woensdag Donderdag Vrijdag Zaterdag Zo Ma Di Wo Do Vr Za".split(" "),
			buttons: "Vandaag Verwijderen Annuleren Hulp Vorige Volgende Einde".split(" ")
		},
		ua: {
			months: "\u0421\u0456\u0447\u0435\u043d\u044c \u041b\u044e\u0442\u0438\u0439 \u0411\u0435\u0440\u0435\u0437\u0435\u043d\u044c \u041a\u0432\u0456\u0442\u0435\u043d\u044c \u0422\u0440\u0430\u0432\u0435\u043d\u044c \u0427\u0435\u0440\u0432\u0435\u043d\u044c \u041b\u0438\u043f\u0435\u043d\u044c \u0421\u0435\u0440\u043f\u0435\u043d\u044c \u0412\u0435\u0440\u0435\u0441\u0435\u043d\u044c \u0416\u043e\u0432\u0442\u0435\u043d\u044c \u041b\u0438\u0441\u0442\u043e\u043f\u0430\u0434 \u0413\u0440\u0443\u0434\u0435\u043d\u044c \u0421\u0456\u0447 \u041b\u044e\u0442 \u0411\u0435\u0440 \u041a\u0432\u0456 \u0422\u0440\u0430 \u0427\u0435\u0440 \u041b\u0438\u043f \u0421\u0435\u0440 \u0412\u0435\u0440 \u0416\u043e\u0432 \u041b\u0438\u0441 \u0413\u0440\u0443".split(" "),
			days: "\u041d\u0435\u0434\u0456\u043b\u044f \u041f\u043e\u043d\u0435\u0434\u0456\u043b\u043e\u043a \u0412\u0456\u0432\u0442\u043e\u0440\u043e\u043a \u0421\u0435\u0440\u0435\u0434\u0430 \u0427\u0435\u0442\u0432\u0435\u0440 \u041f\u2019\u044f\u0442\u043d\u0438\u0446\u044f \u0421\u0443\u0431\u043e\u0442\u0430 \u041d\u0434 \u041f\u043d \u0412\u0442 \u0421\u0440 \u0427\u0442 \u041f\u0442 \u0421\u0431".split(" "),
			buttons: "\u0421\u044c\u043e\u0433\u043e\u0434\u043d\u0456 \u041e\u0447\u0438\u0441\u0442\u0438\u0442\u0438 \u0421\u043a\u0430\u0441\u0443\u0432\u0430\u0442\u0438 \u0414\u043e\u043f\u043e\u043c\u043e\u0433\u0430 \u041d\u0430\u0437\u0430\u0434 \u0412\u043f\u0435\u0440\u0435\u0434 \u0413\u043e\u0442\u043e\u0432\u043e".split(" ")
		},
		ru: {
			months: "\u042f\u043d\u0432\u0430\u0440\u044c \u0424\u0435\u0432\u0440\u0430\u043b\u044c \u041c\u0430\u0440\u0442 \u0410\u043f\u0440\u0435\u043b\u044c \u041c\u0430\u0439 \u0418\u044e\u043d\u044c \u0418\u044e\u043b\u044c \u0410\u0432\u0433\u0443\u0441\u0442 \u0421\u0435\u043d\u0442\u044f\u0431\u0440\u044c \u041e\u043a\u0442\u044f\u0431\u0440\u044c \u041d\u043e\u044f\u0431\u0440\u044c \u0414\u0435\u043a\u0430\u0431\u0440\u044c \u042f\u043d\u0432 \u0424\u0435\u0432 \u041c\u0430\u0440 \u0410\u043f\u0440 \u041c\u0430\u0439 \u0418\u044e\u043d \u0418\u044e\u043b \u0410\u0432\u0433 \u0421\u0435\u043d \u041e\u043a\u0442 \u041d\u043e\u044f \u0414\u0435\u043a".split(" "),
			days: "\u0412\u043e\u0441\u043a\u0440\u0435\u0441\u0435\u043d\u044c\u0435 \u041f\u043e\u043d\u0435\u0434\u0435\u043b\u044c\u043d\u0438\u043a \u0412\u0442\u043e\u0440\u043d\u0438\u043a \u0421\u0440\u0435\u0434\u0430 \u0427\u0435\u0442\u0432\u0435\u0440\u0433 \u041f\u044f\u0442\u043d\u0438\u0446\u0430 \u0421\u0443\u0431\u0431\u043e\u0442\u0430 \u0412\u0441 \u041f\u043d \u0412\u0442 \u0421\u0440 \u0427\u0442 \u041f\u0442 \u0421\u0431".split(" "),
			buttons: "\u0421\u0435\u0433\u043e\u0434\u043d\u044f \u041e\u0447\u0438\u0441\u0442\u0438\u0442\u044c \u041e\u0442\u043c\u0435\u043d\u0438\u0442\u044c \u041f\u043e\u043c\u043e\u0449\u044c \u041d\u0430\u0437\u0430\u0434 \u0412\u043f\u0435\u0440\u0435\u0434 \u0413\u043e\u0442\u043e\u0432\u043e".split(" ")
		},
		zhCN: {
			months: "\u4e00\u6708 \u4e8c\u6708 \u4e09\u6708 \u56db\u6708 \u4e94\u6708 \u516d\u6708 \u4e03\u6708 \u516b\u6708 \u4e5d\u6708 \u5341\u6708 \u5341\u4e00\u6708 \u5341\u4e8c\u6708 \u4e00\u6708 \u4e8c\u6708 \u4e09\u6708 \u56db\u6708 \u4e94\u6708 \u516d\u6708 \u4e03\u6708 \u516b\u6708 \u4e5d\u6708 \u5341\u6708 \u5341\u4e00\u6708 \u5341\u4e8c\u6708".split(" "),
			days: "\u661f\u671f\u65e5 \u661f\u671f\u4e00 \u661f\u671f\u4e8c \u661f\u671f\u4e09 \u661f\u671f\u56db \u661f\u671f\u4e94 \u661f\u671f\u516d \u65e5 \u4e00 \u4e8c \u4e09 \u56db \u4e94 \u516d".split(" "),
			buttons: "\u4eca\u65e5 \u6e05\u9664 Cancel Help Prior Next Finish".split(" ")
		},
		it: {
			months: "Gennaio;Febbraio;Marzo;Aprile;Maggio;Giugno;Luglio;Agosto;Settembre;Ottobre;Novembre;Dicembre;Gen; Feb;Mar;Apr;Mag;Giu;Lug;Ago;Set;Ott;Nov;Dic".split(";"),
			days: "Luned\u00ec Marted\u00ec Mercoled\u00ec Gioved\u00ec Venerd\u00ec Sabato Domenica Lun Mar Mer Gio Ven Sab Dom".split(" "),
			buttons: "Oggi Cancella Cancel Help Prior Next Finish".split(" ")
		},
		de: {
			months: "Januar Februar M\u00e4rz April Mai Juni Juli August September Oktober November Dezember Jan Feb Mrz Apr Mai Jun Jul Aug Sep Okt Nov Dez".split(" "),
			days: "Sonntag Montag Dienstag Mittwoch Donnerstag Freitag Samstag So Mo Di Mi Do Fr Sa".split(" "),
			buttons: "Heute Zur\u00fccksetzen Abbrechen Hilfe Fr\u00fcher Sp\u00e4ter Fertig".split(" ")
		},
		es: {
			months: "Enero Febrero Marzo Abril Mayo Junio Julio Agosto Septiembre Octubre Noviembre Diciembre Ene Feb Mar Abr May Jun Jul Ago Sept Oct Nov Dic".split(" "),
			days: "Domingo Lunes Martes Mi\u00e9rcoles Jueves Viernes S\u00e1bado Do Lu Mar Mi\u00e9 Jue Vi S\u00e1b".split(" "),
			buttons: "Hoy Limpiar Cancel Help Prior Next Finish".split(" ")
		}
	};
	c.Metro.setLocale = function(a, b) {
		c.Metro.Locale[a] = b
	}
})(jQuery);
var hasTouch = "ontouchend" in window,
	eventTimer, moveDirection = "undefined",
	startX, startY, deltaX, deltaY, mouseDown = !1;

function addTouchEvents(c) {
	hasTouch && (c.addEventListener("touchstart", touch2Mouse, !0), c.addEventListener("touchmove", touch2Mouse, !0), c.addEventListener("touchend", touch2Mouse, !0))
}

function touch2Mouse(c) {
	var a = c.changedTouches[0],
		b;
	switch (c.type) {
		case "touchstart":
			b = "mousedown";
			break;
		case "touchend":
			b = "mouseup";
			break;
		case "touchmove":
			b = "mousemove";
			break;
		default:
			return
	}
	"mousedown" == b && (eventTimer = (new Date).getTime(), startX = a.clientX, startY = a.clientY, mouseDown = !0);
	"mouseup" == b && (500 >= (new Date).getTime() - eventTimer ? b = "click" : 1E3 < (new Date).getTime() - eventTimer && (b = "longclick"), eventTimer = 0, mouseDown = !1);
	"mousemove" == b && mouseDown && (deltaX = a.clientX - startX, deltaY = a.clientY - startY,
		moveDirection = deltaX > deltaY ? "horizontal" : "vertical");
	var d = document.createEvent("MouseEvent");
	d.initMouseEvent(b, !0, !0, window, 1, a.screenX, a.screenY, a.clientX, a.clientY, !1, !1, !1, !1, 0, null);
	a.target.dispatchEvent(d);
	c.preventDefault()
};
(function(c) {
	c.widget("metro.accordion", {
		version: "1.0.0",
		options: {
			closeAny: !0,
			open: function(a) {},
			action: function(a) {}
		},
		_frames: {},
		_create: function() {
			var a = this.element;
			void 0 != a.data("closeany") && (this.options.closeAny = a.data("closeany"));
			this._frames = a.children(".accordion-frame");
			this.init()
		},
		init: function() {
			var a = this;
			this._frames.each(function() {
				var b = this,
					d = c(this).children(".heading"),
					e = c(this).children(".content");
				c(d).hasClass("active") && !c(d).attr("disabled") && "none" != c(d).data("action") ?
					(c(e).show(), c(d).removeClass("collapsed")) : c(d).addClass("collapsed");
				d.on("click", function(d) {
					d.preventDefault();
					c(this).attr("disabled") || "none" == c(this).data("action") || (a.options.closeAny && a._closeFrames(), c(e).is(":hidden") ? (c(e).slideDown(), c(this).removeClass("collapsed"), a._trigger("frame", d, {
						frame: b
					}), a.options.open(b)) : (c(e).slideUp(), c(this).addClass("collapsed")), a.options.action(b))
				})
			})
		},
		_closeFrames: function() {
			this._frames.children(".content").slideUp().parent().children(".heading").addClass("collapsed")
		},
		_destroy: function() {},
		_setOption: function(a, b) {
			this._super("_setOption", a, b)
		}
	})
})(jQuery);
(function(c) {
	c.widget("metro.buttonset", {
		version: "1.0.0",
		options: {
			click: function(a, b) {}
		},
		_buttons: {},
		_create: function() {
			this._buttons = this.element.find("button, .button");
			this.init()
		},
		init: function() {
			var a = this;
			this._buttons.each(function() {
				var b = c(this);
				b.on("click", function(d) {
					d.preventDefault();
					b.toggleClass("active");
					a.options.click(b, b.hasClass("active"));
					a._trigger("click", null, {
						button: b,
						on: b.hasClass("active")
					})
				})
			})
		},
		_destroy: function() {},
		_setOption: function(a, b) {
			this._super("_setOption", a,
				b)
		}
	})
})(jQuery);
(function(c) {
	c.widget("metro.buttongroup", {
		version: "1.0.0",
		options: {
			click: function(a, b) {}
		},
		_buttons: {},
		_create: function() {
			this._buttons = this.element.find("button, .button");
			this.init()
		},
		init: function() {
			var a = this;
			this._buttons.each(function() {
				var b = c(this);
				b.on("click", function(d) {
					d.preventDefault();
					a._buttons.removeClass("active");
					b.addClass("active");
					a.options.click(b, b.hasClass("active"));
					a._trigger("click", null, {
						button: b,
						on: b.hasClass("active")
					})
				})
			})
		},
		_destroy: function() {},
		_setOption: function(a, b) {
			this._super("_setOption",
				a, b)
		}
	})
})(jQuery);
var dateFormat = function() {
	var c = /d{1,4}|m{1,4}|yy(?:yy)?|([HhMsTt])\1?|[LloSZ]|"[^"]*"|'[^']*'/g,
		a = /\b(?:[PMCEA][SDP]T|(?:Pacific|Mountain|Central|Eastern|Atlantic) (?:Standard|Daylight|Prevailing) Time|(?:GMT|UTC)(?:[-+]\d{4})?)\b/g,
		b = /[^-+\dA-Z]/g,
		d = function(a, b) {
			a = String(a);
			for (b = b || 2; a.length < b;) a = "0" + a;
			return a
		};
	return function(e, f, g) {
		var h = dateFormat;
		1 != arguments.length || ("[object String]" != Object.prototype.toString.call(e) || /\d/.test(e)) || (f = e, e = void 0);
		e = e ? new Date(e) : new Date;
		f = String(h.masks[f] ||
			f || h.masks["default"]);
		"UTC:" == f.slice(0, 4) && (f = f.slice(4), g = !0);
		locale = $.Metro.currentLocale;
		var k = g ? "getUTC" : "get",
			h = e[k + "Date"](),
			l = e[k + "Day"](),
			n = e[k + "Month"](),
			p = e[k + "FullYear"](),
			m = e[k + "Hours"](),
			q = e[k + "Minutes"](),
			u = e[k + "Seconds"](),
			k = e[k + "Milliseconds"](),
			r = g ? 0 : e.getTimezoneOffset(),
			s = {
				d: h,
				dd: d(h),
				ddd: $.Metro.Locale[locale].days[l],
				dddd: $.Metro.Locale[locale].days[l + 7],
				m: n + 1,
				mm: d(n + 1),
				mmm: $.Metro.Locale[locale].months[n],
				mmmm: $.Metro.Locale[locale].months[n + 12],
				yy: String(p).slice(2),
				yyyy: p,
				h: m % 12 || 12,
				hh: d(m % 12 || 12),
				H: m,
				HH: d(m),
				M: q,
				MM: d(q),
				s: u,
				ss: d(u),
				l: d(k, 3),
				L: d(99 < k ? Math.round(k / 10) : k),
				t: 12 > m ? "a" : "p",
				tt: 12 > m ? "am" : "pm",
				T: 12 > m ? "A" : "P",
				TT: 12 > m ? "AM" : "PM",
				Z: g ? "UTC" : (String(e).match(a) || [""]).pop().replace(b, ""),
				o: (0 < r ? "-" : "+") + d(100 * Math.floor(Math.abs(r) / 60) + Math.abs(r) % 60, 4),
				S: ["th", "st", "nd", "rd"][3 < h % 10 ? 0 : (10 != h % 100 - h % 10) * h % 10]
			};
		return f.replace(c, function(a) {
			return a in s ? s[a] : a.slice(1, a.length - 1)
		})
	}
}();
dateFormat.masks = {
	"default": "ddd mmm dd yyyy HH:MM:ss",
	shortDate: "m/d/yy",
	mediumDate: "mmm d, yyyy",
	longDate: "mmmm d, yyyy",
	fullDate: "dddd, mmmm d, yyyy",
	shortTime: "h:MM TT",
	mediumTime: "h:MM:ss TT",
	longTime: "h:MM:ss TT Z",
	isoDate: "yyyy-mm-dd",
	isoTime: "HH:MM:ss",
	isoDateTime: "yyyy-mm-dd'T'HH:MM:ss",
	isoUtcDateTime: "UTC:yyyy-mm-dd'T'HH:MM:ss'Z'"
};
dateFormat.i18n = {
	dayNames: "Sun Mon Tue Wed Thu Fri Sat Sunday Monday Tuesday Wednesday Thursday Friday Saturday".split(" "),
	monthNames: "Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec January February March April May June July August September October November December".split(" ")
};
Date.prototype.format = function(c, a) {
	return dateFormat(this, c, a)
};
(function(c) {
	c.widget("metro.calendar", {
		version: "1.0.0",
		options: {
			format: "yyyy-mm-dd",
			multiSelect: !1,
			startMode: "day",
			weekStart: void 0 != METRO_WEEK_START ? METRO_WEEK_START : 0,
			otherDays: !1,
			date: new Date,
			buttons: !0,
			locale: c.Metro.currentLocale,
			getDates: function(a) {},
			click: function(a, b) {},
			_storage: []
		},
		_year: 0,
		_month: 0,
		_day: 0,
		_today: new Date,
		_event: "",
		_mode: "day",
		_distance: 0,
		_events: [],
		_create: function() {
			var a = this.element;
			void 0 != a.data("multiSelect") && (this.options.multiSelect = a.data("multiSelect"));
			void 0 !=
				a.data("format") && (this.options.format = a.data("format"));
			void 0 != a.data("date") && (this.options.date = new Date(a.data("date")));
			void 0 != a.data("locale") && (this.options.locale = a.data("locale"));
			void 0 != a.data("startMode") && (this.options.startMode = a.data("startMode"));
			void 0 != a.data("weekStart") && (this.options.weekStart = a.data("weekStart"));
			void 0 != a.data("otherDays") && (this.options.otherDays = a.data("otherDays"));
			this._year = this.options.date.getFullYear();
			this._distance = parseInt(this.options.date.getFullYear()) -
				4;
			this._month = this.options.date.getMonth();
			this._day = this.options.date.getDate();
			this._mode = this.options.startMode;
			a.data("_storage", []);
			this._renderCalendar()
		},
		_renderMonth: function() {
			var a = this._year,
				b = this._month,
				d = 28;
			1 == b && (0 != a % 100 && 0 == a % 4 || 0 == a % 400) && (d = 29);
			var e = ["31", "" + d + "", "31", "30", "31", "30", "31", "31", "30", "31", "30", "31"],
				f = e[b],
				g = (new Date(a, b, 1)).getDay(),
				h, k;
			this.element.html("");
			d = c("<table/>").addClass("bordered");
			h = c("<tr/>");
			c("<td/>").addClass("text-center").html("<a class='btn-previous-year' href='#'><i class='icon-previous'></i></a>").appendTo(h);
			c("<td/>").addClass("text-center").html("<a class='btn-previous-month' href='#'><i class='icon-arrow-left-4'></i></a>").appendTo(h);
			c("<td/>").attr("colspan", 3).addClass("text-center").html("<a class='btn-select-month' href='#'>" + c.Metro.Locale[this.options.locale].months[b] + " " + a + "</a>").appendTo(h);
			c("<td/>").addClass("text-center").html("<a class='btn-next-month' href='#'><i class='icon-arrow-right-4'></i></a>").appendTo(h);
			c("<td/>").addClass("text-center").html("<a class='btn-next-year' href='#'><i class='icon-next'></i></a>").appendTo(h);
			h.addClass("calendar-header").appendTo(d);
			var l;
			h = c("<tr/>");
			for (k = 0; 7 > k; k++) this.options.weekStart ? (l = k + 1, 7 == l && (l = 0), c("<td/>").addClass("text-center day-of-week").html(c.Metro.Locale[this.options.locale].days[l + 7]).appendTo(h)) : c("<td/>").addClass("text-center day-of-week").html(c.Metro.Locale[this.options.locale].days[k + 7]).appendTo(h);
			h.addClass("calendar-subheader").appendTo(d);
			h = this._month - 1;
			0 > h && (h = 11);
			e = e[h];
			l = (this.options.weekStart ? g + 6 : g) % 7;
			var n = "";
			h = c("<tr/>");
			for (k = 0; k < l; k++) this.options.otherDays &&
				(n = e - (l - k - 1)), c("<td/>").addClass("empty").html("<small class='other-day'>" + n + "</small>").appendTo(h);
			g = (this.options.weekStart ? g + 6 : g) % 7;
			for (k = 1; k <= f; k++) g %= 7, 0 == g && (h.appendTo(d), h = c("<tr/>")), e = c("<td/>").addClass("text-center day").html("<a href='#'>" + k + "</a>"), a == this._today.getFullYear() && (b == this._today.getMonth() && this._today.getDate() == k) && e.addClass("today"), l = (new Date(this._year, this._month, k)).format("yyyy-mm-dd"), 0 <= this.element.data("_storage").indexOf(l) && e.find("a").addClass("selected"),
				e.appendTo(h), g++;
			a = "";
			for (k = g + 1; 7 >= k; k++) this.options.otherDays && (a = k - g), c("<td/>").addClass("empty").html("<small class='other-day'>" + a + "</small>").appendTo(h);
			h.appendTo(d);
			this.options.buttons && (h = c("<tr/>").addClass("calendar-actions"), e = c("<td/>").attr("colspan", 7).addClass("text-left").html("<button class='button calendar-btn-today small success'>" + c.Metro.Locale[this.options.locale].buttons[0] + "</button>&nbsp;<button class='button calendar-btn-clear small warning'>" + c.Metro.Locale[this.options.locale].buttons[1] +
				"</button>"), e.appendTo(h), h.appendTo(d));
			d.appendTo(this.element);
			this.options.getDates(this.element.data("_storage"))
		},
		_renderMonths: function() {
			var a, b, d, e, f;
			this.element.html("");
			a = c("<table/>").addClass("bordered");
			b = c("<tr/>");
			c("<td/>").addClass("text-center").html("<a class='btn-previous-year' href='#'><i class='icon-arrow-left-4'></i></a>").appendTo(b);
			c("<td/>").attr("colspan", 2).addClass("text-center").html("<a class='btn-select-year' href='#'>" + this._year + "</a>").appendTo(b);
			c("<td/>").addClass("text-center").html("<a class='btn-next-year' href='#'><i class='icon-arrow-right-4'></i></a>").appendTo(b);
			b.addClass("calendar-header").appendTo(a);
			b = c("<tr/>");
			for (e = f = 0; 12 > e; e++) d = c("<td/>").addClass("text-center month").html("<a href='#' data-month='" + e + "'>" + c.Metro.Locale[this.options.locale].months[e + 12] + "</a>"), this._month == e && (new Date).getFullYear() == this._year && d.addClass("today"), d.appendTo(b), 0 == (f + 1) % 4 && (b.appendTo(a), b = c("<tr/>")), f += 1;
			a.appendTo(this.element)
		},
		_renderYears: function() {
			var a, b, d, e, f;
			this.element.html("");
			a = c("<table/>").addClass("bordered");
			b = c("<tr/>");
			c("<td/>").addClass("text-center").html("<a class='btn-previous-year' href='#'><i class='icon-arrow-left-4'></i></a>").appendTo(b);
			c("<td/>").attr("colspan", 2).addClass("text-center").html(this._distance + "-" + (this._distance + 11)).appendTo(b);
			c("<td/>").addClass("text-center").html("<a class='btn-next-year' href='#'><i class='icon-arrow-right-4'></i></a>").appendTo(b);
			b.addClass("calendar-header").appendTo(a);
			b = c("<tr/>");
			f = 0;
			for (e = this._distance; e < this._distance + 12; e++) d = c("<td/>").addClass("text-center year").html("<a href='#' data-year='" + e + "'>" + e + "</a>"), (new Date).getFullYear() == e && d.addClass("today"), d.appendTo(b), 0 == (f +
				1) % 4 && (b.appendTo(a), b = c("<tr/>")), f += 1;
			a.appendTo(this.element)
		},
		_renderCalendar: function() {
			switch (this._mode) {
				case "year":
					this._renderYears();
					break;
				case "month":
					this._renderMonths();
					break;
				default:
					this._renderMonth()
			}
			this._initButtons()
		},
		_initButtons: function() {
			var a = this,
				b = this.element.find("table");
			"day" == this._mode ? (b.find(".btn-select-month").on("click", function(b) {
				b.preventDefault();
				b.stopPropagation();
				a._mode = "month";
				a._renderCalendar()
			}), b.find(".btn-previous-month").on("click", function(b) {
				a._event =
					"eventPrevious";
				b.preventDefault();
				b.stopPropagation();
				a._month -= 1;
				0 > a._month && (a._year -= 1, a._month = 11);
				a._renderCalendar()
			}), b.find(".btn-next-month").on("click", function(b) {
				a._event = "eventNext";
				b.preventDefault();
				b.stopPropagation();
				a._month += 1;
				12 == a._month && (a._year += 1, a._month = 0);
				a._renderCalendar()
			}), b.find(".btn-previous-year").on("click", function(b) {
				a._event = "eventPrevious";
				b.preventDefault();
				b.stopPropagation();
				a._year -= 1;
				a._renderCalendar()
			}), b.find(".btn-next-year").on("click", function(b) {
				a._event =
					"eventNext";
				b.preventDefault();
				b.stopPropagation();
				a._year += 1;
				a._renderCalendar()
			}), b.find(".calendar-btn-today").on("click", function(b) {
				a._event = "eventNext";
				b.preventDefault();
				b.stopPropagation();
				a.options.date = new Date;
				a._year = a.options.date.getFullYear();
				a._month = a.options.date.getMonth();
				a._day = a.options.date.getDate();
				a._renderCalendar()
			}), b.find(".calendar-btn-clear").on("click", function(b) {
				b.preventDefault();
				b.stopPropagation();
				a.options.date = new Date;
				a._year = a.options.date.getFullYear();
				a._month =
					a.options.date.getMonth();
				a._day = a.options.date.getDate();
				a.element.data("_storage", []);
				a._renderCalendar()
			}), b.find(".day a").on("click", function(d) {
				d.preventDefault();
				d.stopPropagation();
				d = (new Date(a._year, a._month, parseInt(c(this).html()))).format(a.options.format, null);
				var e = new Date(a._year, a._month, parseInt(c(this).html()));
				a.options.multiSelect ? (c(this).toggleClass("selected"), c(this).hasClass("selected") ? a._addDate(d) : a._removeDate(d)) : (b.find(".day a").removeClass("selected"), c(this).addClass("selected"),
					a.element.data("_storage", []), a._addDate(d));
				a.options.getDates(a.element.data("_storage"));
				a.options.click(d, e)
			})) : "month" == this._mode ? (b.find(".month a").on("click", function(b) {
				a._event = "eventNext";
				b.preventDefault();
				b.stopPropagation();
				a._month = parseInt(c(this).data("month"));
				a._mode = "day";
				a._renderCalendar()
			}), b.find(".btn-previous-year").on("click", function(b) {
				a._event = "eventPrevious";
				b.preventDefault();
				b.stopPropagation();
				a._year -= 1;
				a._renderCalendar()
			}), b.find(".btn-next-year").on("click",
				function(b) {
					a._event = "eventNext";
					b.preventDefault();
					b.stopPropagation();
					a._year += 1;
					a._renderCalendar()
				}), b.find(".btn-select-year").on("click", function(b) {
				a._event = "eventNext";
				b.preventDefault();
				b.stopPropagation();
				a._mode = "year";
				a._renderCalendar()
			})) : (b.find(".year a").on("click", function(b) {
				a._event = "eventNext";
				b.preventDefault();
				b.stopPropagation();
				a._year = parseInt(c(this).data("year"));
				a._mode = "month";
				a._renderCalendar()
			}), b.find(".btn-previous-year").on("click", function(b) {
				a._event = "eventPrevious";
				b.preventDefault();
				b.stopPropagation();
				a._distance -= 10;
				a._renderCalendar()
			}), b.find(".btn-next-year").on("click", function(b) {
				a._event = "eventNext";
				b.preventDefault();
				b.stopPropagation();
				a._distance += 10;
				a._renderCalendar()
			}))
		},
		_addDate: function(a) {
			0 > this.element.data("_storage").indexOf(a) && this.element.data("_storage").push(a)
		},
		_removeDate: function(a) {
			a = this.element.data("_storage").indexOf(a);
			this.element.data("_storage").splice(a, 1)
		},
		setDate: function(a) {
			a = new Date(a);
			a = (new Date(a.getFullYear() +
				"/" + (a.getMonth() + 1) + "/" + a.getDate())).format("yyyy-mm-dd");
			this._addDate(a);
			this._renderCalendar()
		},
		getDate: function(a) {
			return (new Date(void 0 != a ? this.element.data("_storage")[a] : this.element.data("_storage")[0])).format(this.options.format)
		},
		getDates: function() {
			return this.element.data("_storage")
		},
		unsetDate: function(a) {
			a = new Date(a);
			a = (new Date(a.getFullYear() + "-" + (a.getMonth() + 1) + "-" + a.getDate())).format("yyyy-mm-dd");
			this._removeDate(a);
			this._renderCalendar()
		},
		_destroy: function() {},
		_setOption: function(a,
			b) {
			this._super("_setOption", a, b)
		}
	})
})(jQuery);
(function(c) {
	c.widget("metro.datepicker", {
		version: "1.0.0",
		options: {
			format: "dd.mm.yyyy",
			date: void 0,
			effect: "none",
			position: "bottom",
			locale: c.Metro.currentLocale,
			weekStart: void 0 != METRO_WEEK_START ? METRO_WEEK_START : 0,
			otherDays: !1,
			selected: function(a, b) {},
			_calendar: void 0
		},
		_create: function() {
			var a = this,
				b = this.element,
				d = b.children("input"),
				e = b.children("button.btn-date");
			void 0 != b.data("date") && (this.options.date = b.data("date"));
			void 0 != b.data("format") && (this.options.format = b.data("format"));
			void 0 !=
				b.data("effect") && (this.options.effect = b.data("effect"));
			void 0 != b.data("position") && (this.options.position = b.data("position"));
			void 0 != b.data("locale") && (this.options.locale = b.data("locale"));
			void 0 != b.data("weekStart") && (this.options.weekStart = b.data("weekStart"));
			void 0 != b.data("otherDays") && (this.options.otherDays = b.data("otherDays"));
			this._createCalendar(b, this.options.date);
			d.attr("readonly", !0);
			e.on("click", function(b) {
				b.stopPropagation();
				"none" == a.options._calendar.css("display") ? a._show() :
					a._hide()
			});
			b.on("click", function(b) {
				b.stopPropagation();
				"none" == a.options._calendar.css("display") ? a._show() : a._hide()
			});
			c("html").on("click", function(a) {
				c(".calendar-dropdown").hide()
			})
		},
		_createCalendar: function(a, b) {
			var d, e = this;
			d = c("<div/>").css({
				position: "absolute",
				display: "none",
				"max-width": 260,
				"z-index": 1E3
			}).addClass("calendar calendar-dropdown").appendTo(a);
			void 0 != e.options.date && d.data("date", e.options.date);
			d.calendar({
				multiSelect: !1,
				format: e.options.format,
				buttons: !1,
				locale: e.options.locale,
				otherDays: e.options.otherDays,
				weekStart: e.options.weekStart,
				click: function(b, c) {
					d.calendar("setDate", c);
					a.children("input[type=text]").val(b);
					e.options.selected(b, c);
					e._hide()
				}
			});
			void 0 != b && (d.calendar("setDate", b), a.children("input[type=text]").val(d.calendar("getDate")));
			switch (this.options.position) {
				case "top":
					d.css({
						top: 0 - d.height(),
						left: 0
					});
					break;
				default:
					d.css({
						top: "100%",
						left: 0
					})
			}
			this.options._calendar = d
		},
		_show: function() {
			"slide" == this.options.effect ? (c(".calendar-dropdown").slideUp("fast"),
				this.options._calendar.slideDown("fast")) : "fade" == this.options.effect ? (c(".calendar-dropdown").fadeOut("fast"), this.options._calendar.fadeIn("fast")) : (c(".calendar-dropdown").hide(), this.options._calendar.show())
		},
		_hide: function() {
			"slide" == this.options.effect ? this.options._calendar.slideUp("fast") : "fade" == this.options.effect ? this.options._calendar.fadeOut("fast") : this.options._calendar.hide()
		},
		_destroy: function() {},
		_setOption: function(a, b) {
			this._super("_setOption", a, b)
		}
	})
})(jQuery);
(function(c) {
	c.widget("metro.carousel", {
		version: "1.0.0",
		options: {
			auto: !0,
			period: 2E3,
			duration: 500,
			effect: "slowdown",
			direction: "left",
			markers: {
				show: !0,
				type: "default",
				position: "left"
			},
			controls: !0,
			stop: !0,
			width: "100%",
			height: 300
		},
		_slides: {},
		_currentIndex: 0,
		_interval: 0,
		_outPosition: 0,
		_create: function() {
			var a = this,
				b = this.options,
				c = carousel = this.element,
				e = carousel.find(".controls");
			void 0 != c.data("auto") && (b.auto = c.data("auto"));
			void 0 != c.data("period") && (b.period = c.data("period"));
			void 0 != c.data("duration") &&
				(b.duration = c.data("duration"));
			void 0 != c.data("effect") && (b.effect = c.data("effect"));
			void 0 != c.data("direction") && (b.direction = c.data("direction"));
			void 0 != c.data("width") && (b.width = c.data("width"));
			void 0 != c.data("height") && (b.height = c.data("height"));
			void 0 != c.data("stop") && (b.stop = c.data("stop"));
			void 0 != c.data("controls") && (b.controls = c.data("controls"));
			void 0 != c.data("markersShow") && (b.markers.show = c.data("markersShow"));
			void 0 != c.data("markersType") && (b.markers.type = c.data("markersType"));
			void 0 != c.data("markersPosition") && (b.markers.position = c.data("markersPosition"));
			carousel.css({
				width: this.options.width,
				height: this.options.height
			});
			this._slides = carousel.find(".slide");
			if (!(1 >= this._slides.length)) {
				!1 !== this.options.markers && (this.options.markers.show && 1 < this._slides.length) && this._markers(a);
				this.options.controls && 1 < this._slides.length ? (carousel.find(".controls.left").on("click", function() {
						a._slideTo("prior")
					}), carousel.find(".controls.right").on("click", function() {
						a._slideTo("next")
					})) :
					e.hide();
				if (this.options.stop) carousel.on("mouseenter", function() {
					clearInterval(a._interval)
				}).on("mouseleave", function() {
					a.options.auto && (a._autoStart(), a.options.period)
				});
				this.options.auto && this._autoStart()
			}
		},
		_autoStart: function() {
			var a = this;
			this._interval = setInterval(function() {
				"left" == a.options.direction ? a._slideTo("next") : a._slideTo("prior")
			}, this.options.period)
		},
		_slideTo: function(a) {
			var b = this._slides[this._currentIndex];
			void 0 == a && (a = "next");
			"prior" === a ? (this._currentIndex -= 1, 0 > this._currentIndex &&
				(this._currentIndex = this._slides.length - 1), this._outPosition = this.element.width()) : "next" === a && (this._currentIndex += 1, this._currentIndex >= this._slides.length && (this._currentIndex = 0), this._outPosition = -this.element.width());
			a = this._slides[this._currentIndex];
			switch (this.options.effect) {
				case "switch":
					this._effectSwitch(b, a);
					break;
				case "slowdown":
					this._effectSlowdown(b, a, this.options.duration);
					break;
				case "fade":
					this._effectFade(b, a, this.options.duration);
					break;
				default:
					this._effectSlide(b, a, this.options.duration)
			}
			var d =
				this;
			this.element.find(".markers ul li a").each(function() {
				c(this).data("num") === d._currentIndex ? c(this).parent().addClass("active") : c(this).parent().removeClass("active")
			})
		},
		_slideToSlide: function(a) {
			var b = this._slides[this._currentIndex],
				c = this._slides[a];
			this._outPosition = a > this._currentIndex ? -this.element.width() : this.element.width();
			switch (this.options.effect) {
				case "switch":
					this._effectSwitch(b, c);
					break;
				case "slowdown":
					this._effectSlowdown(b, c, this.options.duration);
					break;
				case "fade":
					this._effectFade(b,
						c, this.options.duration);
					break;
				default:
					this._effectSlide(b, c, this.options.duration)
			}
			this._currentIndex = a
		},
		_markers: function(a) {
			var b, d, e, f;
			b = c('<div class="markers ' + this.options.markers.type + '" />');
			d = c("<ul></ul>").appendTo(b);
			for (f = 0; f < this._slides.length; f++) e = c('<li><a href="javascript:void(0)" data-num="' + f + '"></a></li>'), 0 === f && e.addClass("active"), e.appendTo(d);
			d.find("li a").removeClass("active").on("click", function() {
				var b = c(this),
					e = b.data("num");
				d.find("li").removeClass("active");
				b.parent().addClass("active");
				if (e == a._currentIndex) return !0;
				a._slideToSlide(e);
				return !0
			});
			b.appendTo(this.element);
			switch (this.options.markers.position) {
				case "top-left":
					b.css({
						left: "10px",
						right: "auto",
						bottom: "auto",
						top: "10px"
					});
					break;
				case "top-right":
					b.css({
						left: "auto",
						right: "10px",
						bottom: "auto",
						top: "0px"
					});
					break;
				case "top-center":
					b.css({
						left: this.element.width() / 2 - b.width() / 2,
						right: "auto",
						bottom: "auto",
						top: "0px"
					});
					break;
				case "bottom-left":
					b.css({
						left: "10px",
						right: "auto"
					});
					break;
				case "bottom-right":
					b.css({
						right: "10px",
						left: "auto"
					});
					break;
				case "bottom-center":
					b.css({
						left: this.element.width() / 2 - b.width() / 2,
						right: "auto"
					})
			}
		},
		_effectSwitch: function(a, b) {
			c(a).hide();
			c(b).css({
				left: 0
			}).show()
		},
		_effectSlide: function(a, b, d) {
			c(a).animate({
				left: this._outPosition
			}, d);
			c(b).css("left", -1 * this._outPosition).show().animate({
				left: 0
			}, d)
		},
		_effectSlowdown: function(a, b, d) {
			d = {
				duration: d,
				easing: "doubleSqrt"
			};
			c.easing.doubleSqrt = function(a) {
				return Math.sqrt(Math.sqrt(a))
			};
			c(a).animate({
				left: this._outPosition
			}, d);
			c(b).css("left", -1 * this._outPosition).show().animate({
					left: 0
				},
				d)
		},
		_effectFade: function(a, b, d) {
			c(a).fadeOut(d);
			c(b).css({
				left: 0
			}).fadeIn(d)
		},
		_destroy: function() {},
		_setOption: function(a, b) {
			this._super("_setOption", a, b)
		}
	})
})(jQuery);
(function(c) {
	c.widget("metro.countdown", {
		version: "1.0.0",
		options: {
			style: {
				background: "bg-dark",
				foreground: "fg-white",
				divider: "fg-dark"
			},
			blink: !0,
			days: 1,
			stoptimer: 0,
			ontick: function(a, b, c, e) {},
			onstop: function() {}
		},
		wrappers: {},
		_interval: 0,
		_create: function() {
			var a = this,
				b = this.element;
			c.each(["Days", "Hours", "Minutes", "Seconds"], function() {
				c('<span class="count' + this + '">').html('<span class="digit-wrapper">                        <span class="digit">0</span>                    </span>                    <span class="digit-wrapper">                        <span class="digit">0</span>                    </span>').appendTo(b);
				"Seconds" != this && b.append('<span class="divider"></span>')
			});
			this.wrappers = this.element.find(".digit-wrapper");
			void 0 != b.data("blink") && (this.options.blink = b.data("blick"));
			void 0 != b.data("styleBackground") && (this.options.style.background = b.data("styleBackground"));
			void 0 != b.data("styleForeground") && (this.options.style.foreground = b.data("styleForeground"));
			void 0 != b.data("styleDivider") && (this.options.style.divider = b.data("styleDivider"));
			"default" != this.options.style.background && this.element.find(".digit").addClass(this.options.style.background);
			"default" != this.options.style.foreground && this.element.find(".digit").addClass(this.options.style.foreground);
			"default" != this.options.style.divider && this.element.find(".divider").addClass(this.options.style.divider);
			void 0 != b.data("stoptimer") && (this.options.stoptimer = new Date(b.data("stoptimer")));
			0 == this.options.stoptimer && (this.options.stoptimer = (new Date).getTime() + 864E5 * this.options.days);
			setTimeout(function() {
				a.tick()
			}, 1E3)
		},
		_destroy: function() {},
		_setOption: function(a, b) {
			this._super("_setOption",
				a, b)
		},
		tick: function() {
			var a = this;
			this._interval = setInterval(function() {
				var b, c, e, f;
				b = Math.floor((a.options.stoptimer - new Date) / 1E3);
				0 > b && (b = 0);
				c = Math.floor(b / 86400);
				a.updateDuo(0, 1, c);
				b -= 86400 * c;
				e = Math.floor(b / 3600);
				a.updateDuo(2, 3, e);
				b -= 3600 * e;
				f = Math.floor(b / 60);
				a.updateDuo(4, 5, f);
				b -= 60 * f;
				a.updateDuo(6, 7, b);
				a.options.ontick(c, e, f, b);
				a.blinkDivider();
				0 === c && (0 === e && 0 === f && 0 === b) && (a.options.onstop(), a.stopDigit(), a._trigger("alarm"), clearInterval(a._interval))
			}, 1E3)
		},
		blinkDivider: function() {
			this.options.blink &&
				this.element.find(".divider").toggleClass("no-visible")
		},
		stopDigit: function() {
			this.wrappers.each(function() {
				c(this).children(".digit").addClass("stop")
			})
		},
		updateDuo: function(a, b, c) {
			this.switchDigit(this.wrappers.eq(a), Math.floor(c / 10) % 10);
			this.switchDigit(this.wrappers.eq(b), c % 10)
		},
		switchDigit: function(a, b) {
			var d = a.find(".digit");
			if (d.is(":animated") || a.data("digit") == b) return !1;
			a.data("digit", b);
			var e = c("<span>", {
				"class": "digit",
				css: {
					top: "-2.1em",
					opacity: 0
				},
				html: b
			});
			e.addClass(this.options.style.background);
			e.addClass(this.options.style.foreground);
			d.before(e).removeClass("static").animate({
				top: "2.5em"
			}, "fast", function() {
				d.remove()
			});
			e.delay(100).animate({
				top: 0,
				opacity: 1
			}, "fast");
			return !0
		}
	})
})(jQuery);
(function(c) {
	c.widget("metro.dropdown", {
		version: "1.0.1",
		options: {
			effect: "slide",
			toggleElement: !1
		},
		_create: function() {
			var a = this,
				b = this.element,
				d = this.name,
				e = this.element.parent(),
				e = this.options.toggleElement || e.children(".dropdown-toggle");
			void 0 != b.data("effect") && (this.options.effect = b.data("effect"));
			e.on("click." + d, function(d) {
				d.preventDefault();
				d.stopPropagation();
				"block" != b.css("display") || b.hasClass("keep-open") ? (c(".dropdown-menu").each(function(d, e) {
					b.parents(".dropdown-menu").is(e) || (c(e).hasClass("keep-open") ||
						"block" != c(e).css("display")) || a._close(e)
				}), a._open(b)) : a._close(b)
			});
			c(b).find("li.disabled a").on("click", function(a) {
				a.preventDefault()
			})
		},
		_open: function(a) {
			switch (this.options.effect) {
				case "fade":
					c(a).fadeIn("fast");
					break;
				case "slide":
					c(a).slideDown("fast");
					break;
				default:
					c(a).hide()
			}
			this._trigger("onOpen", null, a)
		},
		_close: function(a) {
			switch (this.options.effect) {
				case "fade":
					c(a).fadeOut("fast");
					break;
				case "slide":
					c(a).slideUp("fast");
					break;
				default:
					c(a).hide()
			}
			this._trigger("onClose", null, a)
		},
		_destroy: function() {},
		_setOption: function(a, b) {
			this._super("_setOption", a, b)
		}
	})
})(jQuery);
(function(c) {
	c.widget("metro.inputControl", {
		version: "1.0.0",
		options: {},
		_create: function() {
			var a = this.element;
			a.hasClass("text") ? this.initTextInput(a, this) : a.hasClass("password") ? this.initPasswordInput(a, this) : a.hasClass("checkbox") || a.hasClass("radio") || a.hasClass("switch") ? this.initCheckboxInput(a, this) : a.hasClass("file") && this.initFileInput(a, this)
		},
		initCheckboxInput: function(a, b) {},
		initFileInput: function(a, b) {
			var d, e, f;
			f = c("<input type='text' id='__input_file_wrapper__' readonly style='z-index: 1; cursor: default;'>");
			d = a.children(".btn-file");
			e = a.children('input[type="file"]');
			e.css("z-index", 0);
			f.insertAfter(e);
			e.attr("tabindex", "-1");
			d.attr("type", "button");
			e.on("change", function() {
				var a = c(this).val();
				"" != a && f.val(a)
			});
			d.on("click", function() {
				e.trigger("click")
			})
		},
		initTextInput: function(a, b) {
			var d = a.children(".btn-clear"),
				e = a.children("input[type=text]");
			if (0 != d.length && (d.attr("tabindex", "-1"), d.attr("type", "button"), d.on("click", function() {
					e = a.children("input");
					e.prop("readonly") || (e.val(""), e.focus(), b._trigger("onClear",
						null, a))
				}), !e.attr("disabled"))) e.on("click", function() {
				c(this).focus()
			})
		},
		initPasswordInput: function(a, b) {
			var d = a.children(".btn-reveal"),
				e = a.children("input[type=password]");
			if (0 != d.length && (d.attr("tabindex", "-1"), d.attr("type", "button"), d.on("mousedown", function(a) {
					e.attr("type", "text")
				}), d.on("mouseup, mouseleave, blur", function(a) {
					e.attr("type", "password").focus()
				}), !e.attr("disabled"))) e.on("click", function() {
				c(this).focus()
			})
		},
		_destroy: function() {},
		_setOption: function(a, b) {
			this._super("_setOption",
				a, b)
		}
	})
})(jQuery);
(function(c) {
	c.widget("metro.inputTransform", {
		version: "1.0.0",
		options: {
			transformType: "text"
		},
		_create: function() {
			var a = this.element,
				b;
			if (!a.parent().hasClass("input-control")) {
				b = a.get(0).tagName.toLowerCase();
				"textarea" == b ? this.options.transformType = "textarea" : "select" == b ? this.options.transformType = "select" : void 0 != a.data("transformType") ? this.options.transformType = a.data("transformType") : this.options.transformType = a.attr("type");
				a = void 0;
				switch (this.options.transformType) {
					case "password":
						a = this._createInputPassword();
						break;
					case "file":
						a = this._createInputFile();
						break;
					case "checkbox":
						a = this._createInputCheckbox();
						break;
					case "radio":
						a = this._createInputRadio();
						break;
					case "switch":
						a = this._createInputSwitch();
						break;
					case "select":
						a = this._createInputSelect();
						break;
					case "textarea":
						a = this._createInputTextarea();
						break;
					case "search":
						a = this._createInputSearch();
						break;
					case "email":
						a = this._createInputEmail();
						break;
					case "tel":
						a = this._createInputTel();
						break;
					case "number":
						a = this._createInputNum();
						break;
					default:
						a = this._createInputText()
				}
				a.inputControl()
			}
		},
		_createInputTextarea: function() {
			var a = this.element,
				b = c("<div/>").addClass("input-control").addClass("textarea"),
				d = a.clone(!0);
			a.parent();
			d.appendTo(b);
			b.insertBefore(a);
			a.remove();
			return b
		},
		_createInputSelect: function() {
			var a = this.element,
				b = c("<div/>").addClass("input-control").addClass("select"),
				d = a.clone(!0);
			a.parent();
			d.val(a.val()).appendTo(b);
			b.insertBefore(a);
			a.remove();
			return b
		},
		_createInputSwitch: function() {
			var a = this.element,
				b = c("<div/>").addClass("input-control").addClass("switch"),
				d = c("<label/>"),
				e = c("<span/>").addClass("check"),
				f = a.clone(!0);
			a.parent();
			var g = c("<span/>").addClass("caption").html(void 0 != a.data("caption") ? a.data("caption") : "");
			d.appendTo(b);
			f.appendTo(d);
			e.appendTo(d);
			g.appendTo(d);
			b.insertBefore(a);
			a.remove();
			return b
		},
		_createInputCheckbox: function() {
			var a = this.element,
				b = c("<div/>").addClass("input-control").addClass("checkbox"),
				d = c("<label/>"),
				e = c("<span/>").addClass("check"),
				f = a.clone(!0);
			a.parent();
			var g = c("<span/>").addClass("caption").html(void 0 != a.data("caption") ?
				a.data("caption") : "");
			d.appendTo(b);
			f.appendTo(d);
			e.appendTo(d);
			g.appendTo(d);
			b.insertBefore(a);
			a.remove();
			return b
		},
		_createInputRadio: function() {
			var a = this.element,
				b = c("<div/>").addClass("input-control").addClass("radio"),
				d = c("<label/>"),
				e = c("<span/>").addClass("check"),
				f = a.clone(!0);
			a.parent();
			var g = c("<span/>").addClass("caption").html(void 0 != a.data("caption") ? a.data("caption") : "");
			d.appendTo(b);
			f.appendTo(d);
			e.appendTo(d);
			g.appendTo(d);
			b.insertBefore(a);
			a.remove();
			return b
		},
		_createInputSearch: function() {
			return this._createInputVal("text",
				"btn-search")
		},
		_createInputNum: function() {
			return this._createInputVal("number", "btn-clear")
		},
		_createInputTel: function() {
			return this._createInputVal("tel", "btn-clear")
		},
		_createInputEmail: function() {
			return this._createInputVal("email", "btn-clear")
		},
		_createInputText: function() {
			return this._createInputVal("text", "btn-clear")
		},
		_createInputPassword: function() {
			return this._createInputVal("password", "btn-reveal")
		},
		_createInputFile: function() {
			return this._createInputVal("file", "btn-file")
		},
		_createInputVal: function(a,
			b) {
			var d = this.element,
				e = c("<div/>").addClass("input-control").addClass(a),
				f = c("<button/>").addClass(b),
				g = d.clone(!0);
			d.parent();
			g.appendTo(e);
			f.appendTo(e);
			e.insertBefore(d);
			d.remove();
			return e
		},
		_destroy: function() {},
		_setOption: function(a, b) {
			this._super("_setOption", a, b)
		}
	})
})(jQuery);
(function(c) {
	c.widget("metro.livetile", {
		version: "1.0.0",
		options: {
			effect: "slideLeft",
			period: 4E3,
			duration: 700,
			easing: "doubleSqrt"
		},
		_frames: {},
		_currentIndex: 0,
		_interval: 0,
		_outPosition: 0,
		_size: {},
		_create: function() {
			var a = this,
				b = this.element;
			void 0 != b.data("effect") && (this.options.effect = b.data("effect"));
			void 0 != b.data("direction") && (this.options.direction = b.data("direction"));
			void 0 != b.data("period") && (this.options.period = b.data("period"));
			void 0 != b.data("duration") && (this.options.duration = b.data("duration"));
			void 0 != b.data("easing") && (this.options.easing = b.data("easing"));
			this._frames = b.children("[class*='-content']");
			1 >= this._frames.length || (c.easing.doubleSqrt = function(a) {
				return Math.sqrt(Math.sqrt(a))
			}, this._size = {
				width: b.width(),
				height: b.height()
			}, b.on("mouseenter", function() {
				a.stop()
			}), b.on("mouseleave", function() {
				a.start()
			}), this.start())
		},
		start: function() {
			var a = this;
			this._interval = setInterval(function() {
				a._animate()
			}, this.options.period)
		},
		stop: function() {
			clearInterval(this._interval)
		},
		_animate: function() {
			var a =
				this._frames[this._currentIndex],
				b;
			this._currentIndex += 1;
			this._currentIndex >= this._frames.length && (this._currentIndex = 0);
			b = this._frames[this._currentIndex];
			switch (this.options.effect) {
				case "slideLeft":
					this._effectSlideLeft(a, b);
					break;
				case "slideRight":
					this._effectSlideRight(a, b);
					break;
				case "slideDown":
					this._effectSlideDown(a, b);
					break;
				case "slideUpDown":
					this._effectSlideUpDown(a, b);
					break;
				case "slideLeftRight":
					this._effectSlideLeftRight(a, b);
					break;
				default:
					this._effectSlideUp(a, b)
			}
		},
		_effectSlideLeftRight: function(a,
			b) {
			0 == this._currentIndex % 2 ? this._effectSlideLeft(a, b) : this._effectSlideRight(a, b)
		},
		_effectSlideUpDown: function(a, b) {
			0 == this._currentIndex % 2 ? this._effectSlideUp(a, b) : this._effectSlideDown(a, b)
		},
		_effectSlideUp: function(a, b) {
			var d = this._size.height,
				e = {
					duration: this.options.duration,
					easing: this.options.easing
				};
			c(a).animate({
				top: -d
			}, e);
			c(b).css({
				top: d
			}).show().animate({
				top: 0
			}, e)
		},
		_effectSlideDown: function(a, b) {
			var d = this._size.height,
				e = {
					duration: this.options.duration,
					easing: this.options.easing
				};
			c(a).animate({
					top: d
				},
				e);
			c(b).css({
				top: -d
			}).show().animate({
				top: 0
			}, e)
		},
		_effectSlideLeft: function(a, b) {
			var d = this._size.width,
				e = {
					duration: this.options.duration,
					easing: this.options.easing
				};
			c(a).animate({
				left: -1 * d
			}, e);
			c(b).css({
				left: d
			}).show().animate({
				left: 0
			}, e)
		},
		_effectSlideRight: function(a, b) {
			var d = this._size.width,
				e = {
					duration: this.options.duration,
					easing: this.options.easing
				};
			c(a).animate({
				left: d
			}, e);
			c(b).css({
				left: -d
			}).show().animate({
				left: 0
			}, e)
		},
		_destroy: function() {},
		_setOption: function(a, b) {
			this._super("_setOption",
				a, b)
		}
	})
})(jQuery);
(function(c) {
	c.widget("metro.dragtile", {
		version: "1.0.0",
		options: {},
		_create: function() {
			var a = (tile = this.element).parents(".tile-area");
			a.find(".tile");
			a.find(".tile-group");
			tile.attr("draggable", "true");
			addTouchEvents(tile[0]);
			tile[0].addEventListener("dragstart", this._dragStart, !1);
			tile[0].addEventListener("dragend", this._dragEnd, !1);
			tile.on("mousedown", function(a) {});
			tile.on("mouseup", function(a) {})
		},
		_dragStart: function(a) {
			c(this).css("opacity", 0.4)
		},
		_dragEnd: function(a) {
			c(this).css("opacity", 1)
		},
		_destroy: function() {},
		_setOption: function(a, b) {
			this._super("_setOption", a, b)
		}
	})
})(jQuery);
(function(c) {
	c.widget("metro.progressbar", {
		version: "1.0.1",
		options: {
			value: 0,
			color: "bg-cyan",
			animate: !1,
			max: 100,
			onchange: function(a) {}
		},
		_create: function() {
			var a = this.element,
				b = this.options;
			void 0 != a.data("value") && this.value(a.data("value") + "%");
			void 0 != a.data("color") && (b.color = a.data("color"));
			void 0 != a.data("animate") && (b.animate = a.data("animate"));
			void 0 != a.data("max") && (b.max = a.data("max"));
			b.max = 0 > b.max ? 0 : b.max;
			b.max = 100 < b.max ? 100 : b.max;
			this._showBar()
		},
		_showBar: function(a) {
			a = a || this.options.value;
			var b = this.element;
			b.html("");
			var d = c("<div />");
			d.addClass("bar");
			this.options.color.indexOf("bg-") + 1 ? d.addClass(this.options.color) : d.css("background", this.options.color);
			d.appendTo(b);
			this.options.animate ? d.css("width", this.value() + "%").animate({
				width: a + "%"
			}) : d.css("width", a + "%");
			this.options.onchange(this.value())
		},
		value: function(a) {
			if (void 0 != a) a = parseInt(a), a = a > this.max ? this.max : a, a = 0 > a ? 0 : a, this._showBar(a), this.options.value = a;
			else return parseInt(this.options.value)
		},
		color: function(a) {
			this.options.color =
				a;
			this.options.color.indexOf("bg-") + 1 ? this.element.find(".bar").addClass(this.options.color) : this.element.find(".bar").css("background", this.options.color);
			this._showBar()
		},
		_destroy: function() {},
		_setOption: function(a, b) {
			this._super("_setOption", a, b)
		}
	})
})(jQuery);
(function(c) {
	c.widget("metro.rating", {
		version: "1.0.0",
		options: {
			score: 0,
			half: !1,
			stars: 5,
			"static": !0,
			hints: ["bad", "poor", "regular", "good", "gorgeous"],
			showHint: !1,
			showScore: !1,
			scoreHint: "Current score: ",
			click: function(a, b) {}
		},
		_create: function() {
			var a = this.element;
			void 0 != a.data("score") && (this.options.score = a.data("score"));
			void 0 != a.data("half") && (this.options.half = a.data("half"));
			void 0 != a.data("stars") && (this.options.stars = a.data("stars"));
			void 0 != a.data("showHint") && (this.options.showHint = a.data("showHint"));
			void 0 != a.data("static") && (this.options.static = a.data("static"));
			void 0 != a.data("showScore") && (this.options.showScore = a.data("showScore"));
			void 0 != a.data("scoreHint") && (this.options.scoreHint = a.data("scoreHint"));
			this._showRating()
		},
		rate: function(a) {
			this.options.score = a;
			this._showRating()
		},
		_showRating: function() {
			var a = this,
				b = this.element,
				d = this.options,
				e, f;
			b.addClass("rating");
			b.html("");
			e = c("<ul/>");
			d.static || b.addClass("active");
			for (var g = 0; g < d.stars; g++) f = c("<li/>"), f.data("value", g + 1), d.showHint &&
				f.attr("title", d.hints[g]), g <= d.score - 1 && f.addClass("rated"), f.on("click", function() {
					d.click(c(this).data("value"), a)
				}), f.appendTo(e);
			e.appendTo(b);
			d.showScore ? (c("<span/>").addClass("score-hint").html(d.scoreHint + d.score).appendTo(b), b.css("height", "auto")) : b.find("ul").css("margin-bottom", 0)
		},
		_destroy: function() {},
		_setOption: function(a, b) {
			this._super("_setOption", a, b)
		}
	})
})(jQuery);
(function(c) {
	c.widget("metro.slider", {
		version: "1.0.2",
		options: {
			position: 0,
			accuracy: 0,
			color: "default",
			completeColor: "default",
			markerColor: "default",
			colors: [],
			showHint: !1,
			change: function(a, b) {},
			changed: function(a, b) {},
			min: 0,
			max: 100,
			animate: !0,
			_slider: {
				vertical: !1,
				offset: 0,
				length: 0,
				marker: 0,
				ppp: 0,
				start: 0,
				stop: 0
			}
		},
		_create: function() {
			var a = this,
				b = this.element,
				c = this.options,
				e = this.options._slider;
			void 0 != b.data("accuracy") && (c.accuracy = 0 < b.data("accuracy") ? b.data("accuracy") : 0);
			void 0 != b.data("animate") &&
				(c.animate = b.data("animate"));
			void 0 != b.data("min") && (c.min = b.data("min"));
			c.min = 0 > c.min ? 0 : c.min;
			c.min = c.min > c.max ? c.max : c.min;
			void 0 != b.data("max") && (c.max = b.data("max"));
			c.max = 100 < c.max ? 100 : c.max;
			c.max = c.max < c.min ? c.min : c.max;
			void 0 != b.data("position") && (c.position = this._correctValue(b.data("position") > this.options.min ? b.data("position") > this.options.max ? this.options.max : b.data("position") : this.options.min));
			void 0 != b.data("color") && (c.color = b.data("color"));
			void 0 != b.data("completeColor") && (c.completeColor =
				b.data("completeColor"));
			void 0 != b.data("markerColor") && (c.markerColor = b.data("markerColor"));
			void 0 != b.data("colors") && (c.colors = b.data("colors").split(","));
			void 0 != b.data("showHint") && (c.showHint = b.data("showHint"));
			e.vertical = b.hasClass("vertical");
			this._createSlider();
			this._initPoints();
			this._placeMarker(c.position);
			addTouchEvents(b[0]);
			b.children(".marker").on("mousedown", function(b) {
				b.preventDefault();
				a._startMoveMarker(b)
			});
			b.on("mousedown", function(b) {
				b.preventDefault();
				a._startMoveMarker(b)
			})
		},
		_startMoveMarker: function(a) {
			var b = this.element,
				d = this.options,
				e = this,
				f = b.children(".hint");
			c(document).mousemove(function(a) {
				e._movingMarker(a);
				b.hasClass("permanent-hint") || f.css("display", "block")
			});
			c(document).mouseup(function() {
				c(document).off("mousemove");
				c(document).off("mouseup");
				b.data("value", e.options.position);
				b.trigger("changed", e.options.position);
				d.changed(e.options.position, b);
				b.hasClass("permanent-hint") || f.css("display", "none")
			});
			this._initPoints();
			this._movingMarker(a)
		},
		_movingMarker: function(a) {
			var b;
			b = this.options._slider.vertical;
			var c = this.options._slider.offset,
				e = this.options._slider.start,
				f = this.options._slider.stop,
				g = this.options._slider.length,
				h = this.options._slider.marker;
			a = b ? a.pageY - c : a.pageX - c;
			a < e ? a = e : a > f && (a = f);
			b = this._pixToPerc(b ? g - a - h / 2 : a - h / 2);
			this._placeMarker(b);
			this.options.position = b;
			this.options.change(Math.round(b), this.element)
		},
		_placeMarker: function(a) {
			var b, c, e = this.options,
				f = 0,
				g = f = 0,
				h = this.element.children(".marker"),
				k = this.element.children(".complete"),
				l = this.element.children(".hint");
			c = this._percToPix(this.options.position);
			f = e.colors.length;
			g = e._slider.length / f;
			if (this.options._slider.vertical) {
				var n = this._percToPix(this.options.position) + this.options._slider.marker,
					p = this.options._slider.length - n;
				b = this._percToPix(a) + this.options._slider.marker;
				c = this.options._slider.length - b;
				this._animate(h.css("top", p), {
					top: c
				});
				this._animate(k.css("height", n), {
					height: b
				});
				f && (f = Math.round(b / g) - 1, k.css("background-color", e.colors[0 > f ? 0 : f]));
				e.showHint && l.html(Math.round(a)).css("top", c - l.height() /
					2)
			} else b = this._percToPix(a), this._animate(h.css("left", c), {
				left: b
			}), this._animate(k.css("width", c), {
				width: b
			}), f && (f = Math.round(b / g) - 1, k.css("background-color", e.colors[0 > f ? 0 : f])), e.showHint && this._animate(l.html(Math.round(a)).css("left", c - l.width() / 2), {
				left: b - l.width() / 2
			})
		},
		_animate: function(a, b) {
			this.options.animate ? a.stop(!0).animate(b) : a.css(b)
		},
		_pixToPerc: function(a) {
			return this._correctValue(a * this.options._slider.ppp)
		},
		_percToPix: function(a) {
			return 0 === this.options._slider.ppp ? 0 : a / this.options._slider.ppp
		},
		_correctValue: function(a) {
			var b = this.options.accuracy,
				c = this.options.max,
				e = this.options.min;
			if (0 === b) return a;
			if (a === c) return c;
			if (a === e) return e;
			a = Math.floor(a / b) * b + Math.round(a % b / b) * b;
			return a > c ? c : a < e ? e : a
		},
		_initPoints: function() {
			var a = this.options._slider,
				b = this.element;
			a.vertical ? (a.offset = b.offset().top, a.length = b.height(), a.marker = b.children(".marker").height()) : (a.offset = b.offset().left, a.length = b.width(), a.marker = b.children(".marker").width());
			a.ppp = this.options.max / (a.length - a.marker);
			a.start =
				a.marker / 2;
			a.stop = a.length - a.marker / 2
		},
		_createSlider: function() {
			var a = this.element,
				b = this.options,
				d, e;
			a.html("");
			d = c("<div/>").addClass("complete").appendTo(a);
			e = c("<a/>").addClass("marker").appendTo(a);
			b.showHint && c("<span/>").addClass("hint").appendTo(a);
			"default" != b.color && a.css("background-color", b.color);
			"default" != b.completeColor && d.css("background-color", b.completeColor);
			"default" != b.markerColor && e.css("background-color", b.markerColor)
		},
		value: function(a) {
			a = a > this.options.max ? this.options.max :
				a;
			a = a < this.options.min ? this.options.min : a;
			return "undefined" !== typeof a ? (this._placeMarker(parseInt(a)), this.options.position = parseInt(a), this.options.change(Math.round(parseInt(a)), this.element), this) : Math.round(this.options.position)
		},
		_destroy: function() {},
		_setOption: function(a, b) {
			this._super("_setOption", a, b)
		}
	})
})(jQuery);
(function(c) {
	c.widget("metro.tabcontrol", {
		version: "1.0.0",
		options: {
			effect: "none",
			activateStoredTab: !1,
			tabclick: function(a) {},
			tabchange: function(a) {}
		},
		_create: function() {
			var a = this,
				b = this.element,
				d = c(b.children(".tabs")).children("li"),
				e = c(b.children(".frames")).children(".frame"),
				f = b.attr("id");
			void 0 != b.data("effect") && (this.options.effect = b.data("effect"));
			this.init(d, e);
			d.each(function() {
				var b = c(this).children("a");
				b.on("click", function(h) {
					h.preventDefault();
					a.options.tabclick(this);
					if (c(this).parent().hasClass("disabled")) return !1;
					d.removeClass("active");
					b.parent("li").addClass("active");
					e.hide();
					h = c(b.attr("href"));
					switch (a.options.effect) {
						case "slide":
							h.slideDown();
							break;
						case "fade":
							h.fadeIn();
							break;
						default:
							h.show()
					}
					a._trigger("change", null, h);
					a.options.tabchange(this);
					void 0 != f && window.localStorage.setItem(f + "-current-tab", c(this).attr("href"))
				})
			});
			this.options.activateStoredTab && this._activateStoredTab(d)
		},
		init: function(a, b) {
			var d = this;
			a.each(function() {
				if (c(this).hasClass("active")) {
					var a = c(c(c(this).children("a")).attr("href"));
					b.hide();
					a.show();
					d._trigger("change", null, a)
				}
			})
		},
		_activateStoredTab: function(a) {
			var b = window.localStorage.getItem(this.element.attr("id") + "-current-tab");
			void 0 != b && a.each(function() {
				var a = c(this).children("a");
				a.attr("href") == b && a.click()
			})
		},
		_destroy: function() {},
		_setOption: function(a, b) {
			this._super("_setOption", a, b)
		}
	})
})(jQuery);
(function(c) {
	c.widget("metro.tablecontrol", {
		version: "1.0.0",
		options: {
			width: "100%",
			height: "auto",
			cls: "table",
			checkRow: !1,
			colModel: [],
			data: []
		},
		_create: function() {
			var a = this.element;
			a.css({
				width: this.options.width,
				height: this.options.height
			});
			a = this.createTable(a);
			this.addHeader(a, this.options.colModel);
			this.addTableData(a, this.options.data);
			a.addClass(this.options.cls)
		},
		addHeader: function(a, b) {
			var d = c("<thead/>").appendTo(a),
				e = c("<tr/>").appendTo(d);
			c.each(b, function(a, b) {
				c("<th/>").addClass(b.hcls).html(b.caption).appendTo(e)
			})
		},
		createTable: function(a) {
			return c("<table/>").appendTo(a)
		},
		addTableData: function(a, b) {
			var d = this,
				e = c("<tbody/>").appendTo(a);
			c.each(b, function(a, b) {
				d.addRowData(e, b)
			})
		},
		addRowData: function(a, b) {
			var d = c("<tr/>").appendTo(a);
			void 0 != b.__row_class && d.addClass(b.__row_class);
			c.each(this.options.colModel, function(a, f) {
				c("<td/>").css("width", f.width).addClass(f.cls).html(b[f.field]).appendTo(d)
			})
		},
		_destroy: function() {},
		_setOption: function(a, b) {
			this._super("_setOption", a, b)
		}
	})
})(jQuery);
$(function() {
	$("[data-role=table]").tablecontrol()
});
(function(c) {
	c.widget("metro.times", {
		version: "1.0.0",
		options: {
			style: {
				background: "bg-dark",
				foreground: "fg-white",
				divider: "fg-dark"
			},
			blink: !0,
			alarm: {
				h: 0,
				m: 0,
				s: 0
			},
			ontick: function(a, b, c) {},
			onalarm: function() {}
		},
		wrappers: {},
		_interval: 0,
		_create: function() {
			var a = this,
				b = this.element;
			c.each(["Hours", "Minutes", "Seconds"], function() {
				c('<span class="count' + this + '">').html('<span class="digit-wrapper">                        <span class="digit">0</span>                    </span>                    <span class="digit-wrapper">                        <span class="digit">0</span>                    </span>').appendTo(b);
				"Seconds" != this && b.append('<span class="divider"></span>')
			});
			this.wrappers = this.element.find(".digit-wrapper");
			void 0 != b.data("blink") && (this.options.blink = b.data("blick"));
			void 0 != b.data("styleBackground") && (this.options.style.background = b.data("styleBackground"));
			void 0 != b.data("styleForeground") && (this.options.style.foreground = b.data("styleForeground"));
			void 0 != b.data("styleDivider") && (this.options.style.divider = b.data("styleDivider"));
			"default" != this.options.style.background && this.element.find(".digit").addClass(this.options.style.background);
			"default" != this.options.style.foreground && this.element.find(".digit").addClass(this.options.style.foreground);
			"default" != this.options.style.divider && this.element.find(".divider").addClass(this.options.style.divider);
			if (void 0 != b.data("alarm")) {
				var d = b.data("alarm").split(":");
				this.options.alarm.h = void 0 != d[0] ? d[0] : 0;
				this.options.alarm.m = void 0 != d[1] ? d[1] : 0;
				this.options.alarm.s = void 0 != d[2] ? d[2] : 0
			}
			b.data("onalarm");
			setTimeout(function() {
				a.tick()
			}, 1E3)
		},
		_destroy: function() {},
		_setOption: function(a, b) {
			this._super("_setOption",
				a, b)
		},
		tick: function() {
			var a = this;
			this._interval = setInterval(function() {
				var b = new Date,
					c, e;
				c = b.getHours();
				a.updateDuo(0, 1, c);
				e = b.getMinutes();
				a.updateDuo(2, 3, e);
				b = b.getSeconds();
				a.updateDuo(4, 5, b);
				a.options.ontick(c, e, b);
				a.blinkDivider();
				var f = a.options.alarm;
				f && (void 0 != f.h && f.h == c && void 0 != f.m && f.m == e && void 0 != f.s && f.s == b) && (a.options.onalarm(), a._trigger("alarm"))
			}, 1E3)
		},
		blinkDivider: function() {
			this.options.blink && this.element.find(".divider").toggleClass("no-visible")
		},
		updateDuo: function(a, b, c) {
			this.switchDigit(this.wrappers.eq(a),
				Math.floor(c / 10) % 10);
			this.switchDigit(this.wrappers.eq(b), c % 10)
		},
		switchDigit: function(a, b) {
			var d = a.find(".digit");
			if (d.is(":animated") || a.data("digit") == b) return !1;
			a.data("digit", b);
			var e = c("<span>", {
				"class": "digit",
				css: {
					top: "-2.1em",
					opacity: 0
				},
				html: b
			});
			e.addClass(this.options.style.background);
			e.addClass(this.options.style.foreground);
			d.before(e).removeClass("static").animate({
				top: "2.5em",
				opacity: 0
			}, "fast", function() {
				d.remove()
			});
			e.delay(100).animate({
				top: 0,
				opacity: 1
			}, "fast");
			return !0
		}
	})
})(jQuery);
(function(c) {
	c.Dialog = function(a) {
		if (c.Dialog.opened) return METRO_DIALOG;
		c.Dialog.opened = !0;
		c.Dialog.settings = a;
		a = c.extend({
			icon: !1,
			title: "",
			content: "",
			flat: !1,
			shadow: !1,
			overlay: !1,
			width: "auto",
			height: "auto",
			position: "default",
			padding: !1,
			overlayClickClose: !0,
			sysButtons: {
				btnClose: !0
			},
			onShow: function(a) {},
			sysBtnCloseClick: function(a) {},
			sysBtnMinClick: function(a) {},
			sysBtnMaxClick: function(a) {}
		}, a);
		var b, d, e, f;
		b = c("<div/>").addClass("metro window-overlay");
		a.overlay && b.css({
			backgroundColor: "rgba(0,0,0,.7)"
		});
		d = c("<div/>").addClass("window");
		a.flat && d.addClass("flat");
		a.shadow && d.addClass("shadow").css("overflow", "hidden");
		e = c("<div/>").addClass("caption");
		f = c("<div/>").addClass("content");
		f.css({
			paddingTop: 32 + a.padding,
			paddingLeft: a.padding,
			paddingRight: a.padding,
			paddingBottom: a.padding
		});
		a.sysButtons && (a.sysButtons.btnClose && c("<button/>").addClass("btn-close").on("click", function(b) {
			b.preventDefault();
			b.stopPropagation();
			c.Dialog.close();
			a.sysBtnCloseClick(b)
		}).appendTo(e), a.sysButtons.btnMax && c("<button/>").addClass("btn-max").on("click",
			function(b) {
				b.preventDefault();
				b.stopPropagation();
				a.sysBtnMaxClick(b)
			}).appendTo(e), a.sysButtons.btnMin && c("<button/>").addClass("btn-min").on("click", function(b) {
			b.preventDefault();
			b.stopPropagation();
			a.sysBtnMinClick(b)
		}).appendTo(e));
		a.icon && c(a.icon).addClass("icon").appendTo(e);
		c("<div/>").addClass("title").html(a.title).appendTo(e);
		f.html(a.content);
		e.appendTo(d);
		f.appendTo(d);
		d.appendTo(b);
		"auto" != a.width && d.css("min-width", a.width);
		"auto" != a.height && d.css("min-height", a.height);
		b.hide().appendTo("body").fadeIn("fast");
		METRO_DIALOG = d;
		d.css("position", "fixed").css("z-index", parseInt(b.css("z-index")) + 1).css("top", (c(window).height() - METRO_DIALOG.outerHeight()) / 2).css("left", (c(window).width() - d.outerWidth()) / 2);
		addTouchEvents(d[0]);
		if (a.draggable) e.on("mousedown", function(a) {
			c.Dialog.drag = !0;
			e.css("cursor", "move");
			d.css("z-index");
			var b = d.outerHeight(),
				f = d.outerWidth(),
				l = d.offset().top + b - a.pageY,
				n = d.offset().left + f - a.pageX;
			d.css("z-index", 99999).parents().on("mousemove", function(a) {
				var e = 0 < a.pageY ? a.pageY + l - b : 0;
				a = 0 < a.pageX ? a.pageX + n - f : 0;
				c.Dialog.drag && (0 <= e && e <= window.innerHeight - d.outerHeight() && d.offset({
					top: e
				}), 0 <= a && a <= window.innerWidth - d.outerWidth() && d.offset({
					left: a
				}))
			});
			a.preventDefault()
		}).on("mouseup", function() {
			d.removeClass("draggable");
			c.Dialog.drag = !1;
			e.css("cursor", "default")
		});
		d.on("click", function(a) {
			a.stopPropagation()
		});
		if (a.overlayClickClose) b.on("click", function(a) {
			a.preventDefault();
			c.Dialog.close()
		});
		a.onShow(METRO_DIALOG);
		c.Dialog.autoResize();
		return METRO_DIALOG
	};
	c.Dialog.content =
		function(a) {
			return c.Dialog.opened && void 0 != METRO_DIALOG ? a ? (METRO_DIALOG.children(".content").html(a), c.Dialog.autoResize(), !0) : METRO_DIALOG.children(".content").html() : !1
		};
	c.Dialog.title = function(a) {
		if (!c.Dialog.opened || void 0 == METRO_DIALOG) return !1;
		var b = METRO_DIALOG.children(".caption").children(".title");
		a ? b.html(a) : b.html();
		return !0
	};
	c.Dialog.autoResize = function() {
		if (!c.Dialog.opened || void 0 == METRO_DIALOG) return !1;
		var a = METRO_DIALOG.children(".content"),
			b = (c(window).height() - METRO_DIALOG.outerHeight()) /
			2,
			d = (c(window).width() - METRO_DIALOG.outerWidth()) / 2;
		METRO_DIALOG.css({
			width: a.outerWidth(),
			height: a.outerHeight(),
			top: b,
			left: d
		});
		return !0
	};
	c.Dialog.close = function() {
		if (!c.Dialog.opened || void 0 == METRO_DIALOG) return !1;
		c.Dialog.opened = !1;
		METRO_DIALOG.parent(".window-overlay").fadeOut(function() {
			c(this).remove()
		});
		return !1
	}
})(jQuery);
(function(c) {
	var a = !1,
		b = [],
		d = {
			_container: null,
			_notify: null,
			_timer: null,
			options: {
				icon: "",
				caption: "",
				content: "",
				shadow: !0,
				width: "auto",
				height: "auto",
				style: !1,
				position: "right",
				timeout: 3E3
			},
			init: function(a) {
				this.options = c.extend({}, this.options, a);
				this._build();
				return this
			},
			_build: function() {
				a = this._container = a || c("<div/>").addClass("metro notify-container").appendTo("body");
				var d = this.options;
				if ("" == d.content || void 0 == d.content) return !1;
				this._notify = c("<div/>").addClass("notify");
				d.shadow && this._notify.addClass("shadow");
				d.style && void 0 != d.style.background && this._notify.css("background-color", d.style.background);
				d.style && void 0 != d.style.color && this._notify.css("color", d.style.color);
				"" != d.caption && void 0 != d.caption && c("<div/>").addClass("caption").html(d.caption).appendTo(this._notify);
				"" != d.content && void 0 != d.content && c("<div/>").addClass("content").html(d.content).appendTo(this._notify);
				"auto" != d.width && this._notify.css("min-width", d.width);
				"auto" != d.height && this._notify.css("min-height", d.height);
				this._notify.hide().appendTo(this._container).fadeIn("slow");
				b.push(this._notify);
				this.close(d.timeout)
			},
			close: function(a) {
				this.clear();
				if (a == parseInt(a)) {
					var b = this;
					this._timer = setTimeout(function() {
						b._timer = null;
						b._hide()
					}, a)
				} else if (void 0 == a) return this._hide();
				return this
			},
			clear: function() {
				return null != this._timer ? (clearTimeout(this._timer), this._timer = null, this) : !1
			},
			_hide: function() {
				this.clear();
				return void 0 != this._notify ? (this._notify.hide("slow", function() {
					this.remove();
					b.splice(b.indexOf(this._notify), 1)
				}), this) : !1
			},
			closeAll: function() {
				b.forEach(function(a) {
					a.hide("slow",
						function() {
							a.remove();
							b.splice(b.indexOf(a), 1)
						})
				});
				return this
			}
		};
	c.Notify = function(a) {
		return Object.create(d).init(a)
	};
	c.Notify.show = function(a, b) {
		return c.Notify({
			content: a,
			caption: b
		})
	}
})(jQuery);
(function(c) {
	c.widget("metro.listview", {
		version: "1.0.0",
		options: {
			onGroupExpand: function(a) {},
			onGroupCollapse: function(a) {},
			onListClick: function(a) {}
		},
		_create: function() {
			var a = this,
				b = this.element;
			b.children(".collapsed").children(".group-content").hide();
			b.find(".group-title").on("click", function(b) {
				var e = c(this).parent(".list-group"),
					f = e.children(".group-content");
				e.toggleClass("collapsed");
				e.hasClass("collapsed") ? (f.slideUp(), a.options.onGroupCollapse(e)) : (f.slideDown(), a.options.onGroupExpand(e));
				b.preventDefault()
			});
			b.find(".list").on("click", function(d) {
				b.find(".list").removeClass("active");
				c(this).toggleClass("active");
				a.options.onListClick(c(this));
				d.preventDefault()
			})
		},
		_destroy: function() {},
		_setOption: function(a, b) {
			this._super("_setOption", a, b)
		}
	})
})(jQuery);
(function(c) {
	c.widget("metro.treeview", {
		version: "1.0.0",
		options: {
			onNodeClick: function(a) {},
			onNodeCollapsed: function(a) {},
			onNodeExpanded: function(a) {}
		},
		_create: function() {
			var a = this,
				b = this.element;
			b.find(".node.collapsed").find("ul").hide();
			b.find(".node-toggle").on("click", function(b) {
				var e = c(this).parent().parent("li");
				e.hasClass("keep-open") || (e.toggleClass("collapsed"), e.hasClass("collapsed") ? (e.children("ul").fadeOut("fast"), a.options.onNodeCollapsed(e)) : (e.children("ul").fadeIn("fast"), a.options.onNodeExpanded(e)),
					a.options.onNodeClick(e), b.preventDefault(), b.stopPropagation())
			});
			b.find("a").each(function() {
				var a = c(this);
				a.css({
					paddingLeft: 10 * (a.parents("ul").length - 1)
				})
			});
			b.find("a").on("click", function(d) {
				var e = c(this),
					f = e.parent("li");
				b.find("a").removeClass("active");
				e.toggleClass("active");
				a.options.onNodeClick(f);
				d.preventDefault()
			})
		},
		_destroy: function() {},
		_setOption: function(a, b) {
			this._super("_setOption", a, b)
		}
	})
})(jQuery);
(function(c) {
	c.widget("metro.fluentmenu", {
		version: "1.0.0",
		options: {
			onSpecialClick: function(a, b) {},
			onTabClick: function(a, b) {}
		},
		_create: function() {
			var a = this,
				b = this.element,
				d = this.options,
				e = b.find(".tabs-holder > li > a");
			this._hidePanels();
			this._showPanel();
			e.on("click", function(e) {
				if (c(this).parent("li").hasClass("special")) d.onSpecialClick(e, c(this));
				else {
					var g = c(c(this).attr("href"));
					a._hidePanels();
					a._showPanel(g);
					b.find(".tabs-holder > li").removeClass("active");
					c(this).parent("li").addClass("active");
					d.onTabClick(e, c(this))
				}
				e.preventDefault()
			})
		},
		_hidePanels: function() {
			this.element.find(".tab-panel").hide()
		},
		_showPanel: function(a) {
			void 0 == a && (a = this.element.find(".tabs-holder li.active a").attr("href"));
			c(a).show()
		},
		_destroy: function() {},
		_setOption: function(a, b) {
			this._super("_setOption", a, b)
		}
	})
})(jQuery);
(function(c) {
	c.widget("metro.hint", {
		version: "1.0.0",
		options: {
			position: "bottom",
			background: "#FFFCC0",
			shadow: !1,
			border: !1,
			_hint: void 0
		},
		_create: function() {
			var a = this,
				b = this.options;
			this.element.on("mouseenter", function(c) {
				a.createHint();
				b._hint.stop().fadeIn();
				c.preventDefault()
			});
			this.element.on("mouseleave", function(a) {
				b._hint.stop().fadeOut(function() {
					b._hint.remove()
				});
				a.preventDefault()
			})
		},
		createHint: function() {
			var a = this.element,
				b = a.data("hint").split("|"),
				d = this.options;
			void 0 != a.data("hintPosition") &&
				(d.position = a.data("hintPosition"));
			void 0 != a.data("hintBackground") && (d.background = a.data("hintBackground"));
			void 0 != a.data("hintShadow") && (d.shadow = a.data("hintShadow"));
			void 0 != a.data("hintBorder") && (d.border = a.data("hintBorder"));
			if ("TD" == a[0].tagName || "TH" == a[0].tagName) {
				var e = c("<div/>").css("display", "inline-block").html(a.html());
				a.html(e);
				a = e
			}
			var e = 1 < b.length ? b[0] : !1,
				f = 1 < b.length ? b[1] : b[0],
				b = c("<div/>").addClass("hint").appendTo("body");
			e && c("<div/>").addClass("hint-title").html(e).appendTo(b);
			c("<div/>").addClass("hint-text").html(f).appendTo(b);
			b.addClass(d.position);
			d.shadow && b.addClass("shadow");
			d.background && b.css("background-color", d.background);
			d.border && b.css("border-color", d.border);
			"top" == d.position ? b.css({
				top: a.offset().top - c(window).scrollTop() - b.outerHeight() - 20,
				left: a.offset().left - c(window).scrollLeft()
			}) : "bottom" == d.position ? b.css({
				top: a.offset().top - c(window).scrollTop() + a.outerHeight(),
				left: a.offset().left - c(window).scrollLeft()
			}) : "right" == d.position ? b.css({
				top: a.offset().top -
					10 - c(window).scrollTop(),
				left: a.offset().left + a.outerWidth() + 10 - c(window).scrollLeft()
			}) : "left" == d.position && b.css({
				top: a.offset().top - 10 - c(window).scrollTop(),
				left: a.offset().left - b.outerWidth() - 10 - c(window).scrollLeft()
			});
			d._hint = b
		},
		_destroy: function() {},
		_setOption: function(a, b) {
			this._super("_setOption", a, b)
		}
	})
})(jQuery);
(function(c) {
	c.widget("metro.streamer", {
		version: "1.0.0",
		options: {
			scrollBar: !1,
			meter: {
				start: 9,
				stop: 19,
				interval: 20
			},
			slideToGroup: 1,
			slideToTime: "10:20",
			slideSleep: 1E3,
			slideSpeed: 1E3,
			onClick: function(a) {},
			onLongClick: function(a) {}
		},
		_create: function() {
			var a = this,
				b = this.element,
				d = this.options,
				e = b.find(".stream"),
				f = b.find(".event"),
				g = b.find(".events"),
				h = b.find(".events-area"),
				k = b.find(".event-group"),
				l = b.find(".event-stream");
			void 0 != b.data("scrollBar") && (d.scrollBar = b.data("scrollBar"));
			void 0 != b.data("meterStart") &&
				(d.meter.start = parseInt(b.data("meterStart")));
			void 0 != b.data("meterStop") && (d.meter.stop = parseInt(b.data("meterStop")));
			void 0 != b.data("meterInterval") && (d.meter.interval = b.data("meterInterval"));
			void 0 != b.data("slideToGroup") && (d.slideToGroup = parseInt(b.data("slideToGroup")));
			void 0 != b.data("slideSleep") && (d.slideSleep = parseInt(b.data("slideSleep")));
			void 0 != b.data("slideSpeed") && (d.slideSpeed = parseInt(b.data("slideSpeed")));
			b.data("streamSelect", -1);
			var n = c("<ul/>").addClass("meter"),
				p, m, q, u = d.meter.stop,
				r = d.meter.interval,
				s = [];
			for (p = d.meter.start; p < u; p++)
				for (m = 0; 60 > m; m += r) q = (10 > p ? "0" + p : p) + ":" + (10 > m ? "0" + m : m), c("<li/>").addClass("js-interval-" + q.replace(":", "-")).html("<em>" + q + "</em>").appendTo(n), s.push(q);
			b.data("intervals", s);
			n.insertBefore(b.find(".events-grid"));
			b.find(".event-stream").each(function(a, b) {
				var d = 0,
					f = c(b).find(".event");
				f.each(function(a, b) {
					d += c(b).outerWidth()
				});
				c(b).css({
					width: d + 2 * (f.length - 1) + 1
				});
				c(b).find(".time").css("background-color", c(e[a]).css("background-color"))
			});
			g.css({
				"overflow-x": d.scrollBar ?
					"scroll" : "hidden"
			});
			b.css({
				height: b.find(".streams").outerHeight() + (d.scrollBar ? 20 : 0)
			});
			var t = 0;
			k.each(function(a, b) {
				t += c(b).outerWidth()
			});
			t += 2 * (k.length - 1) + 10;
			h.css("width", t);
			f.each(function(a, b) {
				addTouchEvents(b)
			});
			f.mousedown(function(a) {
				a.altKey && c(this).toggleClass("selected")
			});
			b.mousewheel(function(a, b) {
				var c = 50 * b;
				g.scrollLeft(g.scrollLeft() - c);
				return !1
			});
			e.each(function(a, d) {
				c(d).mousedown(function(d) {
					b.data("streamSelect") == a ? (f.removeClass("event-disable"), b.data("streamSelect", -1)) : (b.data("streamSelect",
						a), f.addClass("event-disable"), c(l[a]).find(".event").removeClass("event-disable"))
				})
			});
			f.on("click", function(a) {
				a.preventDefault();
				d.onClick(c(this))
			});
			f.on("longclick", function(a) {
				c(this).toggleClass("selected");
				a.preventDefault();
				d.onLongClick(c(this))
			});
			b.find(".js-go-previous-time").on("click", function(c) {
				c = b.data("intervals").indexOf(b.data("current-time"));
				0 != c && (c--, c = b.data("intervals")[c], a.slideToTime(c, 0, d.slideSpeed))
			});
			b.find(".js-go-next-time").on("click", function(c) {
				c = b.data("intervals").indexOf(b.data("current-time"));
				c != b.data("intervals").length - 1 && (c++, c = b.data("intervals")[c], a.slideToTime(c, 0, d.slideSpeed))
			});
			b.find(".js-show-all-streams").on("click", function(a) {
				b.find(".event").removeClass("event-disable");
				b.data("streamSelect", -1);
				a.preventDefault()
			});
			b.find(".js-schedule-mode").on("click", function(a) {
				c(this).toggleClass("inverse");
				b.data("schedule-mode", c(this).hasClass("inverse"));
				a.preventDefault()
			});
			d.slideToTime ? this.slideToTime(d.slideToTime, d.slideSleep, d.slideSpeed) : this.slideToGroup(d.slideToGroup,
				d.slideSleep, d.slideSpeed)
		},
		slideToTime: function(a, b, c) {
			var e = this,
				f = this.element,
				g = f.find(".meter li.js-interval-" + a.replace(":", "-"))[0],
				h = f.find(".streams").outerWidth() + 2;
			setTimeout(function() {
				f.find(".events").animate({
					scrollLeft: "+=" + (g.offsetLeft - h)
				}, c, function() {
					e._afterSlide()
				})
			}, b);
			f.data("current-time", a)
		},
		slideToGroup: function(a, b, c) {
			var e = this,
				f = this.element,
				g = f.find(".event-group"),
				h = f.find(".streams").outerWidth() + 2;
			setTimeout(function() {
				f.find(".events").animate({
					scrollLeft: "+=" + (g[a -
						1].offsetLeft - h)
				}, c, function() {
					e._afterSlide()
				})
			}, b)
		},
		_afterSlide: function() {},
		_destroy: function() {},
		_setOption: function(a, b) {
			this._super("_setOption", a, b)
		}
	})
})(jQuery);
(function(c) {
	c.widget("metro.scrollbar", {
		version: "1.0.0",
		options: {
			height: "100%",
			width: "100%",
			axis: ["x", "y"],
			wheel: 55
		},
		startSize: {
			width: null,
			height: null
		},
		elemPadding: !1,
		bothScroll: !1,
		scrollbar: null,
		contentHeight: 0,
		contentWidth: 0,
		contentMinHeight: 0,
		contentMinWidth: 0,
		dragElem: null,
		dragStart: !1,
		startCoords: {
			x: 0,
			y: 0
		},
		currCoords: {
			x: 0,
			y: 0
		},
		handlers: !1,
		_create: function() {
			var a = this.element,
				b = this;
			if (void 0 != a.data("scroll")) {
				var d = a.data("scroll");
				"vertical" == d && (this.options.axis = "y");
				"horizontal" == d && (this.options.axis =
					"x");
				"both" == d && (this.options.axis = ["x", "y"])
			}
			void 0 != a.data("height") && (this.options.height = a.data("height"));
			void 0 != a.data("width") && (this.options.width = a.data("width"));
			void 0 != a.data("wheel") && (this.options.wheel = a.data("wheel"));
			a.css({
				position: "relative"
			});
			var d = a.outerWidth(),
				e = a.outerHeight();
			this.contentMinWidth = d;
			this.contentMinHeight = e;
			this.startSize.width = this.options.width;
			this.startSize.height = this.options.height;
			var f = this.startSize.width == parseInt(this.startSize.width) ? this.startSize.width +
				"px" : this.startSize.width,
				g = this.startSize.height == parseInt(this.startSize.height) ? this.startSize.height + "px" : this.startSize.height;
			a.wrap('<div class="scrollbar" style="width: ' + f + "; height: " + g + ';"></div>');
			this.scrollbar = a.parents(".scrollbar").first();
			this.scrollbar.parents().first().css({
				overflow: "hidden"
			});
			this._build(d, e);
			c(window).resize(function() {
				b._resize()
			})
		},
		_resize: function() {
			var a = this.element;
			if (!isNaN(parseInt(this.element.css("left"))) && 0 != parseInt(this.element.css("left")) || !isNaN(parseInt(this.element.css("top"))) &&
				parseInt(this.element.css("top"))) {
				var b = Math.abs(parseInt(this.element.css("left"))),
					c = Math.abs(parseInt(this.element.css("top"))),
					e = this.scrollbar.width(),
					f = this.scrollbar.height();
				this.contentWidth - b < e && (b -= e - (this.contentWidth - b), 0 > b && (b = 0), this.element.css("left", -1 * b));
				this.element.css("left", -1 * b);
				this.contentHeight - c < f && (c -= f - (this.contentHeight - c), 0 > c && (c = 0), this.element.css("top", -1 * c))
			}
			this.options.width = this.startSize.width;
			this.options.height = this.startSize.height;
			this.scrollbar.css({
				padding: 0
			});
			this.elemPadding && (this.element.css({
				paddingRight: "-=5",
				paddingBottom: "-=5"
			}), this.elemPadding = !1);
			0 < this.scrollbar.find(".scrollbar-v").length && this.scrollbar.find(".scrollbar-v").remove();
			0 < this.scrollbar.find(".scrollbar-h").length && this.scrollbar.find(".scrollbar-h").remove();
			0 < this.scrollbar.find(".scrollbar-both").length && this.scrollbar.find(".scrollbar-both").remove();
			b = a.outerWidth();
			a = a.outerHeight();
			this.contentWidth = b;
			this.contentHeight = a;
			this._removeHandlers();
			this._build(b, a)
		},
		_build: function(a,
			b) {
			var c = this.element;
			this.options.width = "100%" == this.options.width ? this.scrollbar.outerWidth() : this.options.width;
			this.options.height = "100%" == this.options.height ? this.scrollbar.outerHeight() : this.options.height;
			this.scrollbar.css({
				width: this.startSize.width,
				height: this.startSize.height
			});
			this.contentWidth = a;
			this.contentHeight = b;
			"y" == this.options.axis ? this.contentHeight > this.options.height ? (this.scrollbar.css({
					paddingRight: 20,
					paddingBottom: 0
				}), a = c.outerWidth(), b = c.outerHeight(), this.contentWidth =
				a, this.contentHeight = b, this._verticalScrollbar(), this._startHandlers()) : (0 < this.scrollbar.find(".scrollbar-v").length && this.scrollbar.find(".scrollbar-v").hide(), this.scrollbar.css({
				paddingRight: 0,
				paddingBottom: 0
			})) : "x" == this.options.axis ? this.contentWidth > this.options.width ? ("100%" == this.startSize.height && (this.scrollbar.css({
				paddingBottom: 20,
				paddingRight: 0
			}), a = c.outerWidth(), b = c.outerHeight(), this.contentWidth = a, this.contentHeight = b), this._horizontalScrollbar(), this._startHandlers()) : (0 < this.scrollbar.find(".scrollbar-h").length &&
				this.scrollbar.find(".scrollbar-h").hide(), this.scrollbar.css({
					paddingBottom: 0,
					paddingRight: 0
				})) : this.contentHeight > this.options.height && this.contentWidth > this.options.width ? (this.bothScroll = !0, 0 < this.scrollbar.find(".scrollbar-both").length ? this.scrollbar.find(".scrollbar-both").show() : this.scrollbar.append('<div class="scrollbar-both"></div>'), this.elemPadding || (this.element.css({
					paddingRight: "+=5",
					paddingBottom: "+=5"
				}), this.elemPadding = !0), a = c.outerWidth(), b = c.outerHeight(), this.contentWidth = a,
				this.contentHeight = b, this._verticalScrollbar(), this._horizontalScrollbar(), this._startHandlers()) : (this.bothScroll = !1, 0 < this.scrollbar.find(".scrollbar-both").length && this.scrollbar.find(".scrollbar-both").hide(), this.elemPadding && (this.element.css({
				paddingRight: "-=5",
				paddingBottom: "-=5"
			}), this.elemPadding = !1), this.contentWidth > this.options.width ? ("100%" == this.startSize.height && (this.scrollbar.css({
					paddingBottom: 20,
					paddingRight: 0
				}), a = c.outerWidth(), b = c.outerHeight(), this.contentWidth = a, this.contentHeight =
				b), this._horizontalScrollbar(), this._startHandlers()) : (0 < this.scrollbar.find(".scrollbar-h").length && this.scrollbar.find(".scrollbar-h").hide(), this.scrollbar.css({
				paddingBottom: 0,
				paddingRight: 0
			})), this.contentHeight > this.options.height ? (this.scrollbar.css({
				paddingRight: 20,
				paddingBottom: 0
			}), a = c.outerWidth(), b = c.outerHeight(), this.contentWidth = a, this.contentHeight = b, this._verticalScrollbar(), this._startHandlers()) : (0 < this.scrollbar.find(".scrollbar-v").length && this.scrollbar.find(".scrollbar-v").hide(),
				this.scrollbar.css({
					paddingRight: 0,
					paddingBottom: 0
				})))
		},
		_verticalScrollbar: function() {
			if (1 > this.scrollbar.find(".scrollbar-v").length) {
				var a = [];
				a[a.length] = '<div class="scrollbar-v">';
				a[a.length] = '<div class="scrollbar-v-up"></div>';
				a[a.length] = '<div class="scrollbar-v-down"></div>';
				a[a.length] = '<div class="scrollbar-line-v">';
				a[a.length] = '<div class="scrollbar-line-v-btn"></div>';
				a[a.length] = "</div>";
				a[a.length] = "</div>";
				a = a.join("");
				this.scrollbar.append(a)
			} else this.scrollbar.find(".scrollbar-v").show();
			var b = this.scrollbar.find(".scrollbar-line-v"),
				a = this.scrollbar.find(".scrollbar-line-v-btn"),
				c = this.scrollbar.find(".scrollbar-v");
			if (this.bothScroll) {
				c.height(this.options.height);
				var e = c.height() - 15;
				this.options.height = e;
				c.height(e)
			} else c.height(this.options.height);
			c = this.options.height - 32;
			e = c / this.contentHeight;
			b.height(c);
			e >= (this.contentHeight - 32) / this.contentHeight ? a.hide() : (b = e * this.options.height, a.show().height(b))
		},
		_horizontalScrollbar: function() {
			if (1 > this.scrollbar.find(".scrollbar-h").length) {
				var a =
					[];
				a[a.length] = '<div class="scrollbar-h">';
				a[a.length] = '<div class="scrollbar-h-up"></div>';
				a[a.length] = '<div class="scrollbar-h-down"></div>';
				a[a.length] = '<div class="scrollbar-line-h">';
				a[a.length] = '<div class="scrollbar-line-h-btn"></div>';
				a[a.length] = "</div>";
				a[a.length] = "</div>";
				a = a.join("");
				this.scrollbar.append(a)
			} else this.scrollbar.find(".scrollbar-h").show();
			var a = this.scrollbar.find(".scrollbar-line-h"),
				b = this.scrollbar.find(".scrollbar-line-h-btn"),
				c = this.scrollbar.find(".scrollbar-h");
			if (this.bothScroll) {
				c.width(this.options.width);
				var e = c.width() - 15;
				this.options.width = e;
				c.width(e)
			} else c.width(this.options.width);
			var c = this.options.width - 32,
				e = c / this.contentWidth,
				f = e * this.options.width,
				g = isNaN(parseInt(this.element.css("left"))) ? 0 : parseInt(this.element.css("left")),
				g = Math.abs(g) * e;
			a.width(c);
			e >= (this.contentWidth - 32) / this.contentWidth ? b.hide() : b.show().width(f).css({
				left: g
			})
		},
		_startHandlers: function() {
			if (this.handlers) return !1;
			this.handlers = !0;
			var a = this;
			c(document).mousemove(function(b) {
				a._drag(b)
			});
			c(document).mouseup(function(b) {
				a._dragEnd(b)
			});
			this.scrollbar.find(".scrollbar-line-v-btn,.scrollbar-line-h-btn").on("mousedown", function(b) {
				a._dragStart(b, c(this))
			});
			this.scrollbar.find(".scrollbar-line-v,.scrollbar-line-h").on("click", function(b) {
				a._clickPos(b, c(this))
			});
			this.scrollbar.find(".scrollbar-v-up,.scrollbar-h-up").on("click", function(b) {
				a._fixScroll(1, c(this))
			});
			this.scrollbar.find(".scrollbar-v-down,.scrollbar-h-down").on("click", function(b) {
				a._fixScroll(-1, c(this))
			});
			this.scrollbar.mousewheel(function(b,
				c) {
				a._fixScroll(c);
				return !1
			})
		},
		_removeHandlers: function() {
			if (!this.handlers) return !1;
			this.handlers = !1;
			c(document).mousemove(function(a) {
				return !1
			});
			c(document).mouseup(function(a) {
				return !1
			});
			this.scrollbar.find(".scrollbar-line-v-btn,.scrollbar-line-h-btn").off("mousedown");
			this.scrollbar.find(".scrollbar-line-v,.scrollbar-line-h").off("click");
			this.scrollbar.find(".scrollbar-v-up,.scrollbar-h-up").off("click");
			this.scrollbar.find(".scrollbar-v-down,.scrollbar-h-down").off("click")
		},
		_clickPos: function(a,
			b) {
			if ("scrollbar-line-v" == c(a.target).attr("class") || "scrollbar-line-h" == c(a.target).attr("class")) {
				var d = b.offset();
				if ("scrollbar-line-v" == c(a.target).attr("class")) {
					var e = a.pageY - d.top,
						f = b.find(".scrollbar-line-v-btn");
					this.dragElem = {
						elem: f,
						width: f.width(),
						height: f.height(),
						parent: b,
						parentWidth: b.width(),
						parentHeight: b.height(),
						parentOffset: d
					};
					this._scrollTo(0, e, "y")
				} else e = a.pageX - d.left, f = b.find(".scrollbar-line-h-btn"), this.dragElem = {
					elem: f,
					width: f.width(),
					height: f.height(),
					parent: b,
					parentWidth: b.width(),
					parentHeight: b.height(),
					parentOffset: d
				}, this._scrollTo(e, 0, "x");
				this.dragElem = null
			}
		},
		_fixScroll: function(a, b) {
			var c, e, f, g = this.options.wheel;
			if (void 0 !== b && (b.hasClass("scrollbar-h-up") || b.hasClass("scrollbar-h-down")) || "x" == this.options.axis || "x" != this.options.axis && "y" != this.options.axis && 1 > this.scrollbar.find(".scrollbar-v").length) {
				var h = 100 * (g / this.contentWidth);
				e = (this.options.width - 32) / 100 * h;
				h = parseInt(this.element.css("left"));
				f = isNaN(h) ? 0 : Math.abs(h);
				h = this.scrollbar.find(".scrollbar-line-h-btn");
				c = this.scrollbar.find(".scrollbar-line-h");
				var k = parseFloat(h.css("left")),
					k = isNaN(k) ? 0 : k;
				0 < a ? (g = f - g, f = k - e) : (g = f + g, f = k + e);
				0 > g && (g = 0);
				g > this.contentWidth - this.options.width && (g = this.contentWidth - this.options.width);
				e = c.width();
				c.height();
				c = h.width();
				h.height();
				0 > f && (f = 0);
				f + c > e && (f = e - c);
				this.element.css({
					left: -1 * g
				});
				h.css({
					left: f
				})
			} else h = 100 * (g / this.contentHeight), e = (this.options.height - 32) / 100 * h, h = parseInt(this.element.css("top")), f = isNaN(h) ? 0 : Math.abs(h), h = this.scrollbar.find(".scrollbar-line-v-btn"),
				c = this.scrollbar.find(".scrollbar-line-v"), k = parseFloat(h.css("top")), k = isNaN(k) ? 0 : k, 0 < a ? (g = f - g, e = k - e) : (g = f + g, e = k + e), 0 > g && (g = 0), g > this.contentHeight - this.options.height && (g = this.contentHeight - this.options.height), c.width(), f = c.height(), h.width(), c = h.height(), 0 > e && (e = 0), e + c > f && (e = f - c), this.element.css({
					top: -1 * g
				}), h.css({
					top: e
				})
		},
		_scrollTo: function(a, b, c) {
			"x" == c ? (c = (this.options.width - 32) / this.contentWidth, b = a / c, 0 > b && (b = 0), b > this.contentWidth - this.options.width && (b = this.contentWidth - this.options.width),
				0 > a && (a = 0), a > this.dragElem.parentWidth - this.dragElem.width && (a = this.dragElem.parentWidth - this.dragElem.width), this.dragElem.elem.css({
					left: a
				}), this.element.css({
					left: -1 * b
				})) : (c = (this.options.height - 32) / this.contentHeight, a = b / c, 0 > a && (a = 0), a > this.contentHeight - this.options.height && (a = this.contentHeight - this.options.height), 0 > b && (b = 0), b > this.dragElem.parentHeight - this.dragElem.height && (b = this.dragElem.parentHeight - this.dragElem.height), this.dragElem.elem.css({
				top: b
			}), this.element.css({
				top: -1 * a
			}))
		},
		_scroll: function() {
			if (this.dragElem.elem.hasClass("scrollbar-line-h-btn")) {
				var a =
					(this.options.width - 32) / this.contentWidth,
					b = parseInt(this.dragElem.elem.css("left")),
					a = (isNaN(b) ? 0 : Math.abs(b)) / a;
				0 > a && (a = 0);
				a > this.contentWidth - this.options.width && (a = this.contentWidth - this.options.width);
				this.element.css({
					left: -1 * a
				})
			} else a = (this.options.height - 32) / this.contentHeight, b = parseInt(this.dragElem.elem.css("top")), a = (isNaN(b) ? 0 : Math.abs(b)) / a, 0 > a && (a = 0), a > this.contentHeight - this.options.height && (a = this.contentHeight - this.options.height), this.element.css({
				top: -1 * a
			})
		},
		_startCoordsDiff: function(a) {
			var b =
				this.dragElem.elem.offset();
			this.startCoords.x = a.pageX - b.left;
			this.startCoords.y = a.pageY - b.top
		},
		_dragStart: function(a, b) {
			var c = b.parents().first();
			this.dragElem = {
				elem: b,
				width: b.width(),
				height: b.height(),
				parent: c,
				parentWidth: c.width(),
				parentHeight: c.height(),
				parentOffset: c.offset()
			};
			this.dragStart = !0;
			this.currCoords.x = a.pageX;
			this.currCoords.y = a.pageY;
			this._startCoordsDiff(a)
		},
		_drag: function(a) {
			if (this.dragStart) {
				this.currCoords.x = a.pageX;
				this.currCoords.y = a.pageY;
				a = this.currCoords.x - this.startCoords.x -
					this.dragElem.parentOffset.left;
				var b = this.currCoords.y - this.startCoords.y - this.dragElem.parentOffset.top;
				0 > a && (a = 0);
				a + this.dragElem.width >= this.dragElem.parentWidth && (a = this.dragElem.parentWidth - this.dragElem.width);
				0 > b && (b = 0);
				b + this.dragElem.height > this.dragElem.parentHeight && (b = this.dragElem.parentHeight - this.dragElem.height);
				this.dragElem.elem.css({
					left: a,
					top: b
				});
				this._scroll()
			}
		},
		_dragEnd: function(a) {
			this.dragStart && (this.dragElem = null, this.dragStart = !1, this.startCoords.x = 0, this.startCoords.y =
				0, this.currCoords.x = null, this.currCoords.y = null)
		},
		_destroy: function() {},
		_setOption: function(a, b) {
			this._super("_setOption", a, b)
		}
	})
})(jQuery);
(function(c) {
	c.widget("metro.stepper", {
		version: "1.0.0",
		options: {
			steps: 3,
			start: 1,
			onStep: function(a, b) {}
		},
		_create: function() {
			var a = this.element,
				b = this.options;
			void 0 != a.data("steps") && (b.steps = a.data("steps"));
			void 0 != a.data("start") && (b.start = a.data("start"));
			this._createStepper();
			this._positioningSteps();
			this._stepTo(b.start)
		},
		_createStepper: function() {
			var a = this.element,
				b = this.options,
				d, e;
			e = c("<ul/>");
			for (d = 0; d < b.steps; d++) c("<li/>").appendTo(e);
			e.appendTo(a)
		},
		_positioningSteps: function() {
			var a =
				this.element,
				b = a.find("li"),
				d = a.width(),
				e = b.length - 1,
				f = c(b[0]).width();
			c.each(b, function(a, b) {
				var k = 0 == a ? 0 : (d - f) / e * a;
				c(b).animate({
					left: k
				})
			})
		},
		_stepTo: function(a) {
			var b = this.options,
				d = this.element.find("li");
			d.removeClass("current").removeClass("complete");
			c.each(d, function(d, f) {
				d < a - 1 && c(f).addClass("complete");
				d == a - 1 && (c(f).addClass("current"), b.onStep(d + 1, f))
			})
		},
		first: function() {
			var a = this.options;
			a.start = 1;
			this._stepTo(a.start)
		},
		last: function() {
			var a = this.options,
				b = this.element.find("li");
			a.start =
				b.length;
			this._stepTo(a.start)
		},
		next: function() {
			var a = this.options,
				b = this.element.find("li");
			a.start + 1 > b.length || (a.start++, this._stepTo(a.start))
		},
		prior: function() {
			var a = this.options;
			0 != a.start - 1 && (a.start--, this._stepTo(a.start))
		},
		_destroy: function() {},
		_setOption: function(a, b) {
			this._super("_setOption", a, b)
		}
	})
})(jQuery);
(function(c) {
	c.widget("metro.pullmenu", {
		version: "1.0.0",
		options: {},
		_create: function() {
			var a = this.element,
				b = void 0 != a.data("relation") ? a.data("relation") : a.parent().children(".element-menu, .horizontal-menu");
			addTouchEvents(a[0]);
			a.on("click", function(a) {
				b.slideToggle();
				a.preventDefault();
				a.stopPropagation()
			})
		},
		_destroy: function() {},
		_setOption: function(a, b) {
			this._super("_setOption", a, b)
		}
	})
})(jQuery);
$(window).resize(function() {
	800 < (0 < window.innerWidth ? window.innerWidth : screen.width) ? $(".element-menu").show() : $(".element-menu").hide()
});
(function(c) {
	c.widget("metro.wizard", {
		version: "1.0.0",
		options: {
			stepper: !0,
			stepperType: "default",
			locale: c.Metro.currentLocale,
			finishStep: "default",
			buttons: {
				cancel: !0,
				help: !1,
				prior: !0,
				next: !0,
				finish: !0
			},
			onCancel: function(a, b) {},
			onHelp: function(a, b) {},
			onPrior: function(a, b) {
				return !0
			},
			onNext: function(a, b) {
				return !0
			},
			onFinish: function(a, b) {},
			onPage: function(a, b) {}
		},
		_stepper: void 0,
		_currentStep: 0,
		_steps: void 0,
		_create: function() {
			var a = this.element,
				b = this.options,
				c = a.find(".step");
			this._steps = c;
			b.stepper &&
				(this._stepper = this._createStepper(c.length).insertBefore(a.find(".steps")));
			void 0 != a.data("locale") && (b.locale = a.data("locale"));
			this._createEvents();
			this.options.onPage(this._currentStep + 1, a)
		},
		_createStepper: function(a) {
			var b = this.options;
			a = c("<div/>").addClass("stepper").attr("data-role", "stepper").attr("data-steps", a);
			"default" != b.stepperType && a.addClass(b.stepperType);
			return a
		},
		_createEvents: function() {
			var a = this,
				b = this.element,
				d = this.options;
			if (d.buttons) {
				var e = c("<div/>").addClass("actions").appendTo(b),
					f = c("<div/>").addClass("group-left").appendTo(e),
					e = c("<div/>").addClass("group-right").appendTo(e);
				if (d.buttons.cancel) c("<button type='button'/>").addClass("btn-cancel").html(c.Metro.Locale[d.locale].buttons[2]).appendTo(f).on("click", function() {
					d.onCancel(a._currentStep + 1, b)
				});
				if (d.buttons.help) c("<button type='button'/>").addClass("btn-help").html(c.Metro.Locale[d.locale].buttons[3]).appendTo(e).on("click", function() {
					d.onHelp(a._currentStep + 1, b)
				});
				if (d.buttons.prior) c("<button type='button'/>").addClass("btn-prior").html(c.Metro.Locale[d.locale].buttons[4]).appendTo(e).on("click",
					function() {
						d.onPrior(a._currentStep + 1, b) && a.prior()
					});
				if (d.buttons.next) c("<button type='button'/>").addClass("btn-next").html(c.Metro.Locale[d.locale].buttons[5]).appendTo(e).on("click", function() {
					d.onNext(a._currentStep + 1, b) && a.next()
				});
				if (d.buttons.finish) c("<button type='button' disabled/>").addClass("btn-finish").html(c.Metro.Locale[d.locale].buttons[6]).appendTo(e).on("click", function() {
					d.onFinish(a._currentStep + 1, b)
				})
			}
		},
		next: function() {
			var a = this._currentStep + 1;
			if (a == this._steps.length) return !1;
			this._currentStep = a;
			this._steps.hide();
			c(this._steps[a]).show();
			this.options.onPage(this._currentStep + 1, this.element);
			this._stepper.stepper("next");
			var b = parseInt("default" == this.options.finishStep ? this._steps.length - 1 : this.options.finishStep);
			a == b ? this.element.find(".btn-finish").attr("disabled", !1) : this.element.find(".btn-finish").attr("disabled", !0);
			return !0
		},
		prior: function() {
			var a = this._currentStep - 1;
			if (0 > a) return !1;
			this._currentStep = a;
			this._steps.hide();
			c(this._steps[a]).show();
			this.options.onPage(this._currentStep +
				1, this.element);
			this._stepper.stepper("prior");
			var b = parseInt("default" == this.options.finishStep ? this._steps.length - 1 : this.options.finishStep);
			a == b ? this.element.find(".btn-finish").attr("disabled", !1) : this.element.find(".btn-finish").attr("disabled", !0);
			return !0
		},
		_destroy: function() {},
		_setOption: function(a, b) {
			this._super("_setOption", a, b)
		}
	})
})(jQuery);
(function(c) {
	c.widget("metro.panel", {
		version: "1.0.0",
		options: {
			onCollapse: function() {},
			onExpand: function() {}
		},
		_create: function() {
			var a = this.element,
				b = this.options,
				c = a.children(".panel-header"),
				e = a.children(".panel-content");
			c.on("click", function() {
				e.slideToggle("fast", function() {
					a.toggleClass("collapsed");
					if (a.hasClass("collapsed")) b.onCollapse();
					else b.onExpand()
				})
			})
		},
		_destroy: function() {},
		_setOption: function(a, b) {
			this._super("_setOption", a, b)
		}
	})
})(jQuery);
(function(c) {
	c.widget("metro.tileTransform", {
		version: "1.0.0",
		options: {},
		_create: function() {
			var a = this.element,
				b = a.width(),
				d = a.height();
			a.on("click", function(a) {});
			a.on("mousedown", function(e) {
				var f = e.pageX - c(this).offset().left;
				e = e.pageY - c(this).offset().top;
				var g = "top";
				f < 1 * b / 3 && (e < 1 * d / 2 || e > 1 * d / 2) ? g = "left" : f > 2 * b / 3 && (e < 1 * d / 2 || e > 1 * d / 2) ? g = "right" : f > 1 * b / 3 && (f < 2 * b / 3 && e > d / 2) && (g = "bottom");
				c(this).addClass("tile-transform-" + g);
				"A" == a[0].tagName && a.attr("href") && setTimeout(function() {
					document.location.href =
						a.attr("href")
				}, 500)
			});
			a.on("mouseup", function() {
				c(this).removeClass("tile-transform-left").removeClass("tile-transform-right").removeClass("tile-transform-top").removeClass("tile-transform-bottom")
			});
			a.on("mouseleave", function() {
				c(this).removeClass("tile-transform-left").removeClass("tile-transform-right").removeClass("tile-transform-top").removeClass("tile-transform-bottom")
			})
		},
		_destroy: function() {},
		_setOption: function(a, b) {
			this._super("_setOption", a, b)
		}
	})
})(jQuery);
(function(c) {
	c.Metro.initAccordions = function(a) {
		void 0 != a ? c(a).find("[data-role=accordion]").accordion() : c("[data-role=accordion]").accordion()
	};
	c.Metro.initButtonSets = function(a) {
		void 0 != a ? (c(a).find("[data-role=button-set]").buttonset(), c(a).find("[data-role=button-group]").buttongroup()) : (c("[data-role=button-set]").buttonset(), c("[data-role=button-group]").buttongroup())
	};
	c.Metro.initCalendars = function(a) {
		void 0 != a ? c(a).find("[data-role=calendar]").calendar() : c("[data-role=calendar]").calendar()
	};
	c.Metro.initCarousels = function(a) {
		void 0 != a ? c(a).find("[data-role=carousel]").carousel() : c("[data-role=carousel]").carousel()
	};
	c.Metro.initCountdowns = function(a) {
		void 0 != a ? c(a).find("[data-role=countdown]").countdown() : c("[data-role=countdown]").countdown()
	};
	c.Metro.initDatepickers = function(a) {
		void 0 != a ? c(a).find("[data-role=datepicker]").datepicker() : c("[data-role=datepicker]").datepicker()
	};
	c.Metro.initDropdowns = function(a) {
		void 0 != a ? c(a).find("[data-role=dropdown]").dropdown() : c("[data-role=dropdown]").dropdown()
	};
	c.Metro.initFluentMenus = function(a) {
		void 0 != a ? c(a).find("[data-role=fluentmenu]").fluentmenu() : c("[data-role=fluentmenu]").fluentmenu()
	};
	c.Metro.initHints = function(a) {
		void 0 != a ? c(a).find("[data-hint]").hint() : c("[data-hint]").hint()
	};
	c.Metro.initInputs = function(a) {
		void 0 != a ? c(a).find("[data-role=input-control], .input-control").inputControl() : c("[data-role=input-control], .input-control").inputControl()
	};
	c.Metro.transformInputs = function(a) {
		void 0 != a ? c(a).find("[data-transform=input-control]").inputTransform() :
			c("[data-transform=input-control]").inputTransform()
	};
	c.Metro.initListViews = function(a) {
		void 0 != a ? c(a).find("[data-role=listview]").listview() : c("[data-role=listview]").listview()
	};
	c.Metro.initLives = function(a) {
		void 0 != a ? c(a).find("[data-role=live-tile], [data-role=live]").livetile() : c("[data-role=live-tile], [data-role=live]").livetile()
	};
	c.Metro.initProgreeBars = function(a) {
		void 0 != a ? c(a).find("[data-role=progress-bar]").progressbar() : c("[data-role=progress-bar]").progressbar()
	};
	c.Metro.initRatings =
		function(a) {
			void 0 != a ? c(a).find("[data-role=rating]").rating() : c("[data-role=rating]").rating()
		};
	c.Metro.initScrolls = function(a) {
		void 0 != a ? c(a).find("[data-role=scrollbox]").scrollbar() : c("[data-role=scrollbox]").scrollbar()
	};
	c.Metro.initSliders = function(a) {
		void 0 != a ? c(a).find("[data-role=slider]").slider() : c("[data-role=slider]").slider()
	};
	c.Metro.initTabs = function(a) {
		void 0 != a ? c(a).find("[data-role=tab-control]").tabcontrol() : c("[data-role=tab-control]").tabcontrol()
	};
	c.Metro.initTimes = function(a) {
		void 0 !=
			a ? c(a).find("[data-role=times]").times() : c("[data-role=times]").times()
	};
	c.Metro.initTrees = function(a) {
		void 0 != a ? c(a).find("[data-role=treeview]").treeview() : c("[data-role=treeview]").treeview()
	};
	c.Metro.initSteppers = function(a) {
		void 0 != a ? c(a).find("[data-role=stepper]").stepper() : c("[data-role=stepper]").stepper()
	};
	c.Metro.initStreamers = function(a) {
		void 0 != a ? c(a).find("[data-role=streamer]").streamer() : c("[data-role=streamer]").streamer()
	};
	c.Metro.initDragTiles = function(a) {
		void 0 != a ? c(a).find("[data-role=drag-drop]").dragtile() :
			c("[data-role=drag-drop]").dragtile()
	};
	c.Metro.initPulls = function(a) {
		void 0 != a && c(a).find("[data-role=pull-menu], .pull-menu").pullmenu();
		c("[data-role=pull-menu], .pull-menu").pullmenu()
	};
	c.Metro.initPanels = function(a) {
		void 0 != a && c(a).find("[data-role=panel]").panel();
		c("[data-role=panel]").panel()
	};
	c.Metro.initTileTransform = function(a) {
		void 0 != a && c(a).find("[data-click=transform]").tileTransform();
		c("[data-click=transform]").tileTransform()
	};
	c.Metro.initAll = function(a) {
		c.Metro.initAccordions(a);
		c.Metro.initButtonSets(a);
		c.Metro.initCalendars(a);
		c.Metro.initCarousels(a);
		c.Metro.initCountdowns(a);
		c.Metro.initDatepickers(a);
		c.Metro.initDropdowns(a);
		c.Metro.initFluentMenus(a);
		c.Metro.initHints(a);
		c.Metro.initInputs(a);
		c.Metro.transformInputs(a);
		c.Metro.initListViews(a);
		c.Metro.initLives(a);
		c.Metro.initProgreeBars(a);
		c.Metro.initRatings(a);
		c.Metro.initScrolls(a);
		c.Metro.initSliders(a);
		c.Metro.initTabs(a);
		c.Metro.initTimes(a);
		c.Metro.initTrees(a);
		c.Metro.initSteppers(a);
		c.Metro.initStreamers(a);
		c.Metro.initDragTiles(a);
		c.Metro.initPulls(a);
		c.Metro.initPanels(a);
		c.Metro.initTileTransform(a)
	}
})(jQuery);
$(function() {
	$.Metro.initAll()
});
$(function() {
	if (METRO_AUTO_REINIT) {
		var c = $(".metro").html(),
			a;
		setInterval(function() {
			a = $(".metro").html();
			c !== a && (c = a, $.Metro.initAll())
		}, 500)
	}
});