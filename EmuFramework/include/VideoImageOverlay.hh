#pragma once

/*  This file is part of Imagine.

	Imagine is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	Imagine is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Imagine.  If not, see <http://www.gnu.org/licenses/> */

#include <gfx/GfxSprite.hh>

class VideoImageOverlay
{
	GfxBufferImage img;
	Pixmap pix;
	GfxSprite spr;
	uint effect;

public:
	GC intensity;

	enum
	{
		NO_EFFECT = 0,
		SCANLINES = 1, SCANLINES_2 = 2,
		CRT = 10,
		CRT_RGB = 20, CRT_RGB_2,

		MAX_EFFECT_VAL = CRT_RGB_2
	};

	constexpr	VideoImageOverlay(): effect(NO_EFFECT), intensity(0.25) { }

	void setEffect(uint effect);
	void place(const GfxSprite &disp);
	void draw();
};
