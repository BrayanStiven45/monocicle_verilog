module sync(
	
	input clk_25,
	input clk_50,
	output hSync,
	output vSync,
	output video_on,
	output [9:0] x,
	output [8:0] y
	
);

	// valores constantes del tamaño de la pantalla
	// tamaño total de la pantalla tanto visible como no visible horizontal 800px
	parameter HVISIBLE = 640; // tamaño de pantalla visible horizontal
	parameter HFP = 16; // tamaño de pantalla de front porch horizontal
	parameter HRETRACE = 96; // tamaño de tiempo de sincronizacion horizontal
	parameter HBP = 48; // tamaño del back poarch horizontal
	parameter HDISPLAYMAX = HVISIBLE + HFP + HRETRACE + HBP - 1; // tamaño de pantalla total horizontal de 800 px
	
	// tamaño total de la pantalla tanto visible como no visible vertical 800px
	parameter V_VISIBLE = 480; // tamaño de pantalla visible vertical
	parameter VFP = 10; // tamaño de pantalla de front porch vertical
	parameter VRETRACE = 2; // tamaño de tiempo de sincronizacion vertical
	parameter VBP = 33; // tamaño del back poarch vertical
	parameter VDISPLAYMAX = V_VISIBLE + VFP + VRETRACE + VBP - 1; // tamaño de pantalla total vertical de 800 px
	
	reg [9:0] h_count;
	reg [9:0] v_count;
	
	always @(posedge clk_25) begin
		if(h_count == HDISPLAYMAX) begin
			h_count = 10'b0;
		end else begin
			h_count = h_count + 10'd1;
		end
		
	end
	
	
	always @(posedge clk_25) begin
		if(h_count == HDISPLAYMAX) begin
			if(v_count == VDISPLAYMAX) begin
				v_count = 10'b0;
			end else begin
				v_count = v_count + 10'd1;
			end
		end
	end
	
	assign hSync = !(h_count >= (HVISIBLE + HFP) && h_count <= (HVISIBLE + HFP + HRETRACE - 1));
	
	assign vSync = !(v_count >= (V_VISIBLE + VFP) && v_count <= (V_VISIBLE + VFP + VRETRACE - 1));
	
	assign video_on = (h_count < HVISIBLE && v_count < V_VISIBLE);
	
	assign x = h_count;
	assign y = v_count[8:0];
	
endmodule

	
	