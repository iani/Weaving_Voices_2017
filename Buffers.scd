OSCFunc.trace(false);

Server.local.boot

(
OSCdef.new(
	\thread0,
	{
		arg msg, time, addr, port;
		x.set(\t_trig[1]);
	},
	'/0'
);
OSCdef.new(
	\thread1,
	{
		arg msg, time, addr, port;
		x.set(\t_trig[1]);
	},
	'/1'
);
OSCdef.new(
	\thread11,
	{
		arg msg, time, addr, port;
		x.set(\t_trig, msg[1]);
	},
	'/11'
);
)

~sounds = Array.new;
~folder = PathName.new("/Users/chrisfunk/Desktop/Sounds/");
(
~folder.entries.do( {
	arg path;
	~sounds = ~sounds.add(Buffer.read(s, path.fullPath));
} );
)

~sounds.at(0).play;

(
SynthDef.new(\playbuf_test, {
	arg amp=1, out=0, buf, rate=1, t_trig=1, start=0, da=0;
	var sig;
	sig = PlayBuf.ar(2, buf, BufRateScale.kr(buf) * rate, t_trig, start, doneAction:da);
	sig = sig * amp;
	Out.ar(out, sig);
} ).add;
)


x = Synth.new(\playbuf_test, [\buf, ~sounds[2].bufnum, \da, 0]);
x.set(\t_trig, 1);
x.free
