const { touchDown, touchMove, touchUp, usleep, appActivate, toast } = at

// simulate swapping horizontally
function swipeHorizontally() {
	for (let i = 0; i < 5; i++) {
		touchDown(1, 900, 300)
		for (let x = 900; x >= 100; x -= 30) {
			usleep(8000)
			touchMove(1, x, 300)
		}
		touchUp(1, 100, 300)
		usleep(300000)
	}
}

// simulate swapping vertically
function swipeVertically() {
	for (let i = 0; i < 5; i++) {
		touchDown(1, 200, 300);
		for (let y = 300; y <= 900; y += 30) {
			usleep(8000)
			touchMove(1, 200, y);
		}
		touchUp(1, 200, 900);
		usleep(300000)
	}
}

function run() {
	// activate AutoTouch app
	appActivate("me.autotouch.AutoTouch.ios8");
	// show message through toast
	toast("Swiping...");
	// simulate swapping vertically
	swipeVertically();
	// wait a moment
	usleep(1000000);
	// show message through toast
	toast("Switching to Home Screen...");
	// back to home screen
	appActivate("com.apple.SpringBoard");
	// wait a moment
	usleep(1000000);
	// simulate swapping horizontally
	swipeHorizontally();
}

// export `run()` method from this module
module.exports = {
	run
}