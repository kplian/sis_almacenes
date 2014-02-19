<?php
require_once dirname(__FILE__) . '/pxpReport/Report.php';
//require_once dirname(__FILE__) . '/../../lib/tcpdf/tcpdf.php';
//ini_set('display_errors', 'On');
class CustomReport extends TCPDF {

    private $dataSource;
	public $headerFistPage=true;

    public function setDataSource(DataSource $dataSource) {
        $this->dataSource = $dataSource;
    }

    public function getDataSource() {
        return $this->dataSource;
    }

    public function Header() {
        $height = 6;
        $midHeight = 9;
        $longHeight = 18;

        $x = $this->GetX();
        $y = $this->GetY();
        $this->SetXY($x, $y);
		$dataSource = $this->getDataSource();

        $this->Image(dirname(__FILE__).'/../../lib/images/k_logo_reporte.jpg', 19, 9, 36);

        $this->SetFontSize(14);
        $this->SetFont('', 'B');
        $this->Cell(44, $midHeight, '', 'LRT', 0, 'C', false, '', 0, false, 'T', 'C');
		$tmpDatos=$dataSource->getDataset();
		$this->Cell(105, $midHeight, strtoupper($tmpDatos[0]['tipo']) . ' VALORADO DE MATERIALES', 'LRT', 0, 'C', false, '', 0, false, 'T', 'C');

        $x = $this->GetX();
        $y = $this->GetY();
        $this->Ln();
        $this->Cell(44, $midHeight, '', 'LRB', 0, 'C', false, '', 0, false, 'T', 'C');
        $this->Cell(105, $midHeight, $tmpDatos[0]['nombre_almacen'], 'LRB', 0, 'C', false, '', 0, false, 'T', 'C');

        $this->SetFontSize(7);

        $width1 = 15;
        $width2 = 25;
        $this->SetXY($x, $y);

        $this->SetFont('', '');
        $this->Cell(44, $longHeight, '', 1, 0, 'C', false, '', 0, false, 'T', 'C');

        $this->SetXY($x, $y);
        $this->setCellPaddings(2);
        $this->Cell($width1-4, $height, 'Código:', "B", 0, '', false, '', 0, false, 'T', 'C');
        $this->SetFont('', 'B');
        $this->Cell($width2+8, $height, $tmpDatos[0]['codigo_mov'], "B", 0, 'C', false, '', 0, false, 'T', 'C');

        $this->SetFont('', '');
        $y += $height;
        $this->SetXY($x, $y);
        $this->setCellPaddings(2);
        $this->Cell($width1+4, $height, 'Fecha:', "B", 0, '', false, '', 0, false, 'T', 'C');
        $this->SetFont('', 'B');
        $this->Cell($width2, $height, $tmpDatos[0]['fecha_mov'], "B", 0, 'L', false, '', 0, false, 'T', 'C');

        $this->SetFont('', '');
        $y += $height;
        $this->SetXY($x, $y);
        $this->setCellPaddings(2);
        $this->Cell($width1, $height, 'Página:', "B", 0, '', false, '', 0, false, 'T', 'C');
        $this->SetFont('', 'B');
        $this->Cell($w = $width2, $h = $height, $txt = $this->getAliasNumPage() . ' de ' . $this->getAliasNbPages(), $border = "B", $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		
		
		$wNro = 10;
        $wCodigo = 15;
        $wDescripcionItem = 90;
        $wUnidad = 15;
        $wCantidad = 20;
        $wCostoUnitario = 15;
        $wCostoTotal = 20;
		$cantTot=0;
		$costoUnitTot=0;
		$hGlobal = 5;
		
		if($this->headerFistPage==false){
			$this->headerFistPage=true;
		} else{
			$this->Ln();
			$this->SetFontSize(6.5);
	        $this->SetFont('', 'B');
	        $this->Cell($w = $wNro-2, $h = $hGlobal, $txt = 'Nro.', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
	        $this->Cell($w = $wCodigo, $h = $hGlobal, $txt = 'Código', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
	        $this->Cell($w = $wDescripcionItem-10, $h = $hGlobal, $txt = 'Descripcion del Material', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
	        $this->Cell($w = $wUnidad, $h = $hGlobal, $txt = 'Unidad', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
	        $this->Cell($w = $wCantidad, $h = $hGlobal, $txt = 'Cantidad Sol.', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
			$this->Cell($w = $wCantidad, $h = $hGlobal, $txt = 'Cantidad Real', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
	        $this->Cell($w = $wCostoUnitario, $h = $hGlobal, $txt = 'Costo Unit.', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
	        $this->Cell($w = $wCostoTotal, $h = $hGlobal, $txt = 'Costo Total', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
	        $this->Ln();			
		}

    }

    public function Footer() {
        //TODO: implement the footer manager
    }

}

Class RMovimiento extends Report {

    function write($fileName) {
        $pdf = new CustomReport(PDF_PAGE_ORIENTATION, PDF_UNIT, "LETTER", true, 'UTF-8', false);
		$pdf->headerFistPage=false;
        $pdf->setDataSource($this->getDataSource());
        $dataSource = $this->getDataSource();
        // set document information
        $pdf->SetCreator(PDF_CREATOR);
        /*$pdf->SetAuthor('Nicola Asuni');
         $pdf->SetTitle('TCPDF Example 006');
         $pdf->SetSubject('TCPDF Tutorial');
         $pdf->SetKeywords('TCPDF, PDF, example, test, guide');
         */

        // set default monospaced font
        $pdf->SetDefaultMonospacedFont(PDF_FONT_MONOSPACED);

        //set margins
        $pdf->SetMargins(PDF_MARGIN_LEFT, 30, PDF_MARGIN_RIGHT);
        $pdf->SetHeaderMargin(7);
        $pdf->SetFooterMargin(PDF_MARGIN_FOOTER);

        //set auto page breaks
        $pdf->SetAutoPageBreak(TRUE, PDF_MARGIN_BOTTOM);

        //set image scale factor
        $pdf->setImageScale(PDF_IMAGE_SCALE_RATIO);

        //set some language-dependent strings
        // $pdf->setLanguageArray($l);

        // add a page
        $pdf->AddPage();

        $hGlobal = 5;
        $hMin = 3.5;
        $hMedium = 7.5;
        $hLong = 15;
		
		//Carga el dataset en un temporal
		$tmpDatos=$dataSource->getDataset();

        $pdf->SetFontSize(7.5);
        $pdf->SetFont('', 'B');
		//$hMedium
        $pdf->Cell($w = 30, $h = 1, $txt = 'MOTIVO: ', $border = 0, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->SetFont('', '');
        $pdf->Cell($w = 60, $h = 1, $txt = $tmpDatos[0]['nombre_movimiento_tipo'], $border = 0, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Ln();

        $pdf->SetFont('', 'B');
        $pdf->Ln();
        $pdf->Cell($w = 30, $h = $hMedium, $txt = 'DESCRIPCION: ', $border = 0, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		//var_dump($tmpDatos[0]);exit;
        if ($tmpDatos[0]['descripcion'] != null && $tmpDatos[0]['descripcion'] != '') {
            $pdf->SetFont('', '');
            if (strlen($dataSource->getParameter('descripcion')) > 150) {
                $pdf->MultiCell($w = 0, $h = $hLong, $txt = $tmpDatos[0]['descripcion'], $border = 0, $align = 'L', $fill = false, $ln = 1, $x = '', $y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
            } else {
                $pdf->Cell($w = 0, $h = $hMedium, $txt = $tmpDatos[0]['descripcion'], $border = 0, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
                $pdf->Ln();
            }
        } else {
            $pdf->Ln();
        }
		
		//Fecha del movimiento
        $pdf->SetFont('', 'B');
        $pdf->Cell($w = 30, $h = $hMedium, $txt = 'FECHA ' . strtoupper($tmpDatos[0]['tipo']) . ':', $border = 0, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->SetFont('', '');
        //$fechaMovimiento = new DateTime($dataSource->getParameter('fechaMovimiento'));
        $pdf->Cell($w = 60, $h = $hMedium, $txt = $tmpDatos[0]['fecha_mov'], $border = 0, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		
		//Fecha de la ultima modificacion
		/*$pdf->SetFont('', 'B');
        $pdf->Cell($w = 30, $h = $hMedium, $txt = 'FECHA REMISION: ', $border = 0, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->SetFont('', '');
        $fechaRemision = new DateTime($dataSource->getParameter('fechaRemision'));
        $pdf->Cell($w = 60, $h = $hMedium, $txt = $tmpDatos[0]['fecha_mod'], $border = 0, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		*/
        
        if ($dataSource->getParameter('motivo') == "Inventario Inicial") {
            $wMargin = 30;
            $wNro = 10;
            $wDetalle = 110;
            $wTotal = 20;
            
            $pdf->Ln();
            $pdf->Ln();
            $pdf->SetFontSize(7);
            $pdf->SetFont('', 'B');
            $pdf->Cell($w = $wMargin, $h = $hGlobal, $txt = '', $border = 0, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wNro, $h = $hGlobal, $txt = 'Nro.', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wDetalle, $h = $hGlobal, $txt = 'Detalle', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wTotal+10, $h = $hGlobal, $txt = 'Costo', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Ln();
            $count = 1;
            $pdf->SetFont('', '');
            foreach ($dataSource->getDataSet() as $row) {
                $pdf->Cell($w = $wMargin, $h = $hGlobal, $txt = '', $border = 0, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
                $pdf->Cell($w = $wNro, $h = $hGlobal, $txt = $count, $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
                $pdf->Cell($w = $wDetalle, $h = $hGlobal, $txt = $row['nombreClasificacion'], $border = 1, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
                $pdf->Cell($w = $wTotal+10, $h = $hGlobal, $txt = number_format($row['totalClasificacion'], 6), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
                $pdf->Ln();
                $count++;
            }
            $pdf->SetFont('', 'B');
            $pdf->Cell($w = $wMargin, $h = $hGlobal, $txt = '', $border = 0, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wNro, $h = $hGlobal, $txt = '', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wDetalle, $h = $hGlobal, $txt = 'COSTO TOTAL', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wTotal+10, $h = $hGlobal, $txt = number_format($dataSource->getParameter('costoTotal'), 6), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
    
            $pdf->Ln();
            $pdf->Ln();
            $pdf->SetFont('', 'B');
            $pdf->Cell($w = 30, $h = $hMedium, $txt = 'OBSERVACIONES: ', $border = 0, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->SetFont('', '');
            $pdf->MultiCell($w = 0, $h = $hLong, $txt = $dataSource->getParameter('observaciones'), $border = 0, $align = 'L', $fill = false, $ln = 1, $x = '', $y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
    
            $pdf->AddPage();
    
            $pdf->SetFontSize(8);
            $pdf->SetFont('', 'B');
    
            $pdf->Cell($w = 0, $h = $hMedium, $txt = 'DETALLE DE MATERIALES', $border = 0, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Ln();
            foreach ($dataSource->getParameter('clasificacionDataSources') as $clasificacionDataSource) {
                $this->writeClasificationDetail($pdf, $clasificacionDataSource);
            }
        } else {
            $this->writeGlobalDetail($pdf, $dataSource);
            $pdf->Ln();
            $pdf->SetFont('', 'B');
            $pdf->Cell($w = 30, $h = $hGlobal, $txt = 'OBSERVACIONES: ', $border = 0, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->SetFont('', '');
            if ($dataSource->getParameter('observaciones') != null && $dataSource->getParameter('observaciones') != '') {
                $pdf->MultiCell($w = 0, $h = $hMedium, $txt = $dataSource->getParameter('observaciones'), $border = 0, $align = 'L', $fill = false, $ln = 0, $x = '', $y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
            } 
            
            if ($dataSource->getParameter('tipoMovimiento') == "salida") {
                $wMargin = 0;
                $wColumn1 = 90;
                $wColumn2 = 90;
                
                $pdf->Ln();
                $pdf->Ln();
                $pdf->Cell($w = $wColumn1, $h = $hMin, $txt = $dataSource->getParameter('solicitante'), $border = 0, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
                $pdf->Cell($w = $wColumn2, $h = $hMin, $txt = '', $border = 0, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
                $pdf->Ln();
                $pdf->Cell($w = $wColumn1, $h = $hMin, $txt = 'SOLICITANTE', $border = 0, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
                $pdf->Cell($w = $wColumn2, $h = $hMin, $txt = 'APROBADOR', $border = 0, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
                
                $pdf->Ln();
                $pdf->Ln();
                $pdf->Ln();
                $pdf->Ln();
                $pdf->Cell($w = $wColumn1, $h = $hGlobal, $txt = '____________________________', $border = 0, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
                $pdf->Cell($w = $wColumn2, $h = $hGlobal, $txt = '____________________________', $border = 0, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
                $pdf->Ln();
                $pdf->Cell($w = $wColumn1, $h = $hGlobal, $txt = 'Entregado Por: ___________________________', $border = 0, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
                $pdf->Cell($w = $wColumn2, $h = $hGlobal, $txt = 'Entregado A: ___________________________', $border = 0, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            }
        }

        $pdf->Output($fileName, 'F');
    }

    function writeClasificationDetail($pdf, $dataSource) {
        $hGlobal = 5;
        $wNro = 10;
        $wCodigo = 15;
        $wDescripcionItem = 90;
        $wUnidad = 15;
        $wCantidad = 20;
        $wCostoUnitario = 15;
        $wCostoTotal = 20;
        $pdf->Ln();
		$cantTot=0;
		$costoUnitTot=0;

        $pdf->SetFontSize(7);
        $pdf->SetFont('', 'B');

        $pdf->Cell($w = $wDescripcion, $h = $hGlobal, $txt = '* ' . $dataSource->getParameter('nombreClasificacion'), $border = 0, $ln = 1, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');

        $pdf->SetFontSize(6.5);
        $pdf->SetFont('', 'B');
        $pdf->Cell($w = $wNro-2, $h = $hGlobal, $txt = 'Nro.', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCodigo, $h = $hGlobal, $txt = 'Código', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wDescripcionItem-10, $h = $hGlobal, $txt = 'Descripcion del Material', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wUnidad, $h = $hGlobal, $txt = 'Unidad', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCantidad, $h = $hGlobal, $txt = 'Cantidad Sol.', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Cell($w = $wCantidad, $h = $hGlobal, $txt = 'Cantidad Real', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCostoUnitario, $h = $hGlobal, $txt = 'Costo Unit.', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCostoTotal, $h = $hGlobal, $txt = 'Costo Total', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Ln();

        $count = 1;
        $pdf->SetFont('', '');
        foreach ($dataSource->getDataset() as $datarow) {
            $pdf->Cell($w = $wNro-2, $h = $hGlobal, $txt = $count, $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wCodigo, $h = $hGlobal, $txt = $datarow['codigo'], $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wDescripcionItem-10, $h = $hGlobal, $txt = $datarow['nombre'], $border = 1, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wUnidad, $h = $hGlobal, $txt = $datarow['unidad_medida'], $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wCantidad, $h = $hGlobal, $txt = number_format($datarow['cantidad_solicitada'], 2), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
			$pdf->Cell($w = $wCantidad, $h = $hGlobal, $txt = number_format($datarow['cantidad'], 2), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wCostoUnitario, $h = $hGlobal, $txt = number_format($datarow['costo_unitario'], 6), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wCostoTotal, $h = $hGlobal, $txt = number_format($datarow['costo_total'], 6), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Ln();
            $count++;
			$cantTot+=$datarow['cantidad'];
			$costoUnitTot+=$datarow['costo_unitario'];
       	}

        $pdf->SetFont('', 'B');
        $pdf->Cell($w = $wNro-2, $h = $hGlobal, $txt = '', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCodigo, $h = $hGlobal, $txt = '', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wDescripcionItem-$wCantidad+10, $h = $hGlobal, $txt = 'Totales', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wUnidad, $h = $hGlobal, $txt = '', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Cell($w = $wCantidad, $h = $hGlobal, $txt = number_format($cantTot,6), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCantidad, $h = $hGlobal, $txt = number_format($cantTot,6), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCostoUnitario, $h = $hGlobal, $txt = number_format($costoUnitTot,6), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCostoTotal, $h = $hGlobal, $txt = number_format($dataSource->getParameter('totalCosto'), 6), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Ln();
    }
    
    function writeGlobalDetail($pdf, $dataSource) {
        $hGlobal = 5;
        $wNro = 10;
        $wCodigo = 15;
        $wDescripcionItem = 90;
        $wUnidad = 15;
        $wCantidad = 20;
        $wCostoUnitario = 15;
        $wCostoTotal = 20;
		$cantTot=0;
		$costoUnitTot=0;
        $pdf->Ln();
        
        $pdf->SetFontSize(6.5);
        $pdf->SetFont('', 'B');
        $pdf->Cell($w = $wNro-2, $h = $hGlobal, $txt = 'Nro.', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCodigo, $h = $hGlobal, $txt = 'Código', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wDescripcionItem-10, $h = $hGlobal, $txt = 'Descripcion del Material', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wUnidad, $h = $hGlobal, $txt = 'Unidad', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Cell($w = $wCantidad, $h = $hGlobal, $txt = 'Cantidad Sol.', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCantidad, $h = $hGlobal, $txt = 'Cantidad Real', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCostoUnitario, $h = $hGlobal, $txt = 'Costo Unit.', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCostoTotal, $h = $hGlobal, $txt = 'Costo Total', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Ln();
        
        $count = 1;
        $pdf->SetFont('', '');
        foreach ($dataSource->getDataSet() as $datarow) {
            $pdf->Cell($w = $wNro-2, $h = $hGlobal, $txt = $count, $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wCodigo, $h = $hGlobal, $txt = $datarow['codigo'], $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wDescripcionItem-10, $h = $hGlobal, $txt = $datarow['nombre'], $border = 1, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wUnidad, $h = $hGlobal, $txt = $datarow['unidad_medida'], $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wCantidad, $h = $hGlobal, $txt = number_format($datarow['cantidad_solicitada'], 2), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
			$pdf->Cell($w = $wCantidad, $h = $hGlobal, $txt = number_format($datarow['cantidad'], 2), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wCostoUnitario, $h = $hGlobal, $txt = number_format($datarow['costo_unitario'], 6), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wCostoTotal, $h = $hGlobal, $txt = number_format($datarow['costo_total'], 6), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Ln();
            $count++;
			$cantTot+=$datarow['cantidad'];
			$costoUnitTot+=$datarow['costo_unitario'];
        }

        $pdf->SetFont('', 'B');
        $pdf->Cell($w = $wNro-2, $h = $hGlobal, $txt = '', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCodigo, $h = $hGlobal, $txt = '', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wDescripcionItem-$wCantidad+10, $h = $hGlobal, $txt = 'Totales', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wUnidad, $h = $hGlobal, $txt = '', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCantidad, $h = $hGlobal, $txt = number_format($cantTot,6), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Cell($w = $wCantidad, $h = $hGlobal, $txt = number_format($cantTot,6), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCostoUnitario, $h = $hGlobal, $txt = number_format($costoUnitTot,6), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCostoTotal, $h = $hGlobal, $txt = number_format($dataSource->getParameter('totalCosto'), 6), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Ln();
    }

}
?>