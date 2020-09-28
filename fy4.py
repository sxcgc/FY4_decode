from unpack_fy4 import unpack_fy4,unpack_fy4_latlon,unpack_fy4_retau,pack_fy4_marker
import Ngl
import numpy as np
import glob
import matplotlib.pyplot as plt

filenames = sorted(glob.glob("/d2/cgc/FY4A_OUTPUT/*FY4A-*.bin"))
lat,lon = unpack_fy4_latlon("/d2/cgc/FY4/FY4_AGRI_4KM_latlon.bin")
lat = np.ma.array(lat.T)
lon = np.ma.array(lon.T)


wks = Ngl.open_wks("png","T")
res = Ngl.Resources()

# Contour options
res.cnFillOn          = True          # turn on contour fill
res.cnLinesOn         = False         # turn off contour lines
res.cnLineLabelsOn    = False         # turn off line labels
res.cnFillMode        = "RasterFill"        # These two resources
#res.cnLevelSpacingF   = 2.5              # contour level spacing
res.trGridType        = "TriangularMesh"    # can speed up plotting.
res.cnFillPalette     = "WhViBlGrYeOrRe"
#
# Map options
res.mpDataBaseVersion = "MediumRes"
res.mpLimitMode       = "LatLon"
res.mpMinLatF         = 0
res.mpMaxLatF         = 60
res.mpMinLonF         = 70
res.mpMaxLonF         = 140
res.mpGridAndLimbOn   = False
#
res.sfXArray          = lon
res.sfYArray          = lat

for name in filenames:
    print(name)
    output = unpack_fy4(name)
    outputname = name.split("/")[-1].split("_")
    output_use = []

    for i in range(17):
        output_use.append(np.ma.masked_values(output[i].T,-999.9))
    tb12 = output_use[11]
    res.tiMainString = outputname[-4]
    plt.imsave("/d2/cgc/FY4/output/"+outputname[-4]+".png",tb12,cmap="rainbow",vmax = 320,vmin = 190)
    plot = Ngl.contour_map(wks,tb12,res)
Ngl.end()


