<?php
require_once dirname(__FILE__) . '/pxpReport/Report.php';
require_once dirname(__FILE__) . '/pxpReport/DataSource.php';
//require_once dirname(__FILE__) . '/../../lib/tcpdf/tcpdf.php';
//ini_set('display_errors', 'On');
class CustomReport extends TCPDF {

    private $dataSource;

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

        $this->Image(dirname(__FILE__).$_SESSION['_DIR_LOGO'], 16, 12, 36);

        $this->SetFontSize(14);
        $this->SetFont('', 'B');
        $this->Cell(40, $longHeight, '', 'LRTB', 0, 'C', false, '', 0, false, 'T', 'C');
        $this->Cell(105, $longHeight, ' REPORTE DE EXISTENCIAS', 'LRTB', 0, 'C', false, '', 0, false, 'T', 'C');

        $x = $this->GetX();
        $y = $this->GetY();

        $this->SetFontSize(7);

        $width1 = 15;
        $width2 = 25;
        $this->SetXY($x, $y);

        $this->SetFont('', '');
        $this->Cell(40, $longHeight, '', 1, 0, 'C', false, '', 0, false, 'T', 'C');

        $this->SetXY($x, $y);
        $this->setCellPaddings(2);
        $this->Cell($width1, $height, 'Codigo:', "B", 0, '', false, '', 0, false, 'T', 'C');
        $this->SetFont('', 'B');
        $this->Cell($width2, $height, 'BOA-EXIST', "B", 0, 'C', false, '', 0, false, 'T', 'C');

        $this->SetFont('', '');
        $y += $height;
        $this->SetXY($x, $y);
        $this->setCellPaddings(2);
        $this->Cell($width1, $height, 'Fecha:', "B", 0, '', false, '', 0, false, 'T', 'C');
        $this->SetFont('', 'B');
        $this->Cell($width2, $height, date("d/m/Y"), "B", 0, 'C', false, '', 0, false, 'T', 'C');

        $this->SetFont('', '');
        $y += $height;
        $this->SetXY($x, $y);
        $this->setCellPaddings(2);
        $this->Cell($width1, $height, 'Página:', "B", 0, '', false, '', 0, false, 'T', 'C');
        $this->SetFont('', 'B');
        $this->Cell($w = $width2, $h = $height, $txt = $this->getAliasNumPage() . ' de ' . $this->getAliasNbPages(), $border = "B", $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
    }

    public function Footer() {
        //TODO: implement the footer manager
    }

}

Class RExistencias extends Report {

    function write($fileName) {
        $pdf = new CustomReport(PDF_PAGE_ORIENTATION, PDF_UNIT, "LETTER", true, 'UTF-8', false);
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
        $pdf->SetHeaderMargin(10);
        $pdf->SetFooterMargin(PDF_MARGIN_FOOTER);

        //set auto page breaks
        $pdf->SetAutoPageBreak(TRUE, PDF_MARGIN_BOTTOM);

        //set image scale factor
        $pdf->setImageScale(PDF_IMAGE_SCALE_RATIO);

        //set some language-dependent strings
        // $pdf->setLanguageArray($l);

        // Crea la pagina para mostrar los totales de los almacenes.
        $pdf->AddPage();

        $hGlobal = 5;
        $hMedium = 7.5;
        $hLong = 15;

        
        //$pdf->Cell($w = 30, $h = $hGlobal, $txt = '', $border = 0, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		//$pdf->SetFontSize(12);
		$pdf->SetFont('', 'B');
        $pdf->Cell($w = 180, $h = $hMedium, $txt = 'Al  '.$dataSource->getParameter('fechaHasta'), $border = 0, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Ln();

		$pdf->SetFontSize(7.5);
		$pdf->SetFont('', '');
        $wMargin = 15;
        $wNro = 10;
        $wCodigo = 15;
        $wDetalle = 110;
        $wTotal = 20;

        //TODO: Se tiene que adicionar un bucle para mostrar las tablas totales por cada almacen.
        $pdf->SetFontSize(7);
        $pdf->SetFont('', 'B');
        $pdf->Cell($w = $wMargin, $h = $hGlobal, $txt = '', $border = 0, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wNro+$wCodigo+$wDetalle+$wTotal, $h = $hGlobal, $txt = '', $border = 0, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Ln();
        
        $pdf->SetFontSize(7);
        $pdf->SetFont('', 'B');
        $pdf->Cell($w = $wMargin, $h = $hGlobal, $txt = '', $border = 0, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wNro, $h = $hGlobal, $txt = 'Nro.', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        //$pdf->Cell($w = $wCodigo, $h = $hGlobal, $txt = 'Codigo', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wDetalle+$wCodigo, $h = $hGlobal, $txt = 'Detalle', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wTotal, $h = $hGlobal, $txt = 'Costo', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Ln();
        $count = 1;
        $pdf->SetFont('', '');
        foreach ($dataSource->getDataSet() as $row) {
            $pdf->Cell($w = $wMargin, $h = $hGlobal, $txt = '', $border = 0, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wNro, $h = $hGlobal, $txt = $count, $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            //$pdf->Cell($w = $wCodigo, $h = $hGlobal, $txt = "1.2.1.5", $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wDetalle+$wCodigo, $h = $hGlobal, $txt = $row['nombreClasificacion'], $border = 1, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wTotal, $h = $hGlobal, $txt = number_format($row['totalClasificacion'], 2), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Ln();
            $count++;
        }
        $pdf->SetFont('', 'B');
        $pdf->Cell($w = $wMargin, $h = $hGlobal, $txt = '', $border = 0, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wNro, $h = $hGlobal, $txt = '', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        //$pdf->Cell($w = $wCodigo, $h = $hGlobal, $txt = '', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wDetalle+$wCodigo, $h = $hGlobal, $txt = 'COSTO TOTAL', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wTotal, $h = $hGlobal, $txt = number_format($dataSource->getParameter('costoTotal'), 2), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');

        $pdf->Ln();
        $pdf->Ln();
                
        $pdf->AddPage();

        $pdf->SetFontSize(8);
        $pdf->SetFont('', 'B');

        $pdf->Cell($w = 0, $h = $hMedium, $txt = 'DETALLE DE MATERIALES', $border = 0, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Ln();
        foreach ($dataSource->getParameter('clasificacionDataSources') as $clasificacionDataSource) {
            $this->writeClasificacionDetalle($pdf, $clasificacionDataSource);
        }
		
		$pdf->Cell($w = $wDetalle+$wCodigo+40, $h = $hGlobal, $txt = 'COSTO TOTAL', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = 20, $h = $hGlobal, $txt = number_format($dataSource->getParameter('costoTotal'), 2), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');

        $pdf->Output($fileName, 'F');
    }

    function writeClasificacionDetalle($pdf, $dataSource) {
        $hGlobal = 5;
        
        $wNro = 10;
        $wCodigo = 15;
        $wDescripcionItem = 80;
        $wUnidad = 15;
        $wCantidad = 15;
		$wCantidadAlerta = 15;
        $wCostoUnitario = 15;
        $wCostoTotal = 20;
        $pdf->Ln();

        $pdf->SetFontSize(7);
        $pdf->SetFont('', 'B');

        $pdf->Cell($w = $wDescripcionItem, $h = $hGlobal, $txt = '* ' . $dataSource->getParameter('nombreClasificacion'), $border = 0, $ln = 1, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');

        $pdf->SetFontSize(6.5);
        $pdf->SetFont('', 'B');
        $pdf->Cell($w = $wNro, $h = $hGlobal, $txt = 'Nro.', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCodigo, $h = $hGlobal, $txt = 'Código', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wDescripcionItem, $h = $hGlobal, $txt = 'Descripcion del Material', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wUnidad, $h = $hGlobal, $txt = 'Unidad', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCantidad, $h = $hGlobal, $txt = 'Cantidad', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
		$pdf->Cell($w = $wCantidad, $h = $hGlobal, $txt = 'Cant. Min.', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCostoUnitario, $h = $hGlobal, $txt = 'C/Unit.', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCostoTotal, $h = $hGlobal, $txt = 'C/Total', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Ln();

        $count = 1;
        $pdf->SetFont('', '');
        foreach ($dataSource->getDataset() as $datarow) {

            $pdf->Cell($w = $wNro, $h = $hGlobal, $txt = $count, $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wCodigo, $h = $hGlobal, $txt = $datarow['codigo'], $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wDescripcionItem, $h = $hGlobal, $txt = $datarow['nombre'], $border = 1, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wUnidad, $h = $hGlobal, $txt = $datarow['unidad_medida'], $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wCantidad, $h = $hGlobal, $txt = number_format($datarow['cantidad'], 2), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
			$pdf->Cell($w = $wCantidadAlerta, $h = $hGlobal, $txt = number_format($datarow['cantidad_min'], 2), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $costoUnitario = 0;
            if ($datarow['cantidad'] != 0) {
                $costoUnitario = $datarow['costo']/$datarow['cantidad'];
            }
            $pdf->Cell($w = $wCostoUnitario, $h = $hGlobal, $txt = number_format($costoUnitario, 2), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wCostoTotal, $h = $hGlobal, $txt = number_format($datarow['costo'], 2), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Ln();
            $count++;
        }

        $pdf->SetFont('', 'B');
        $pdf->Cell($w = $wNro, $h = $hGlobal, $txt = '', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCodigo, $h = $hGlobal, $txt = '', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wDescripcionItem, $h = $hGlobal, $txt = 'Total', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wUnidad, $h = $hGlobal, $txt = '', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCantidad, $h = $hGlobal, $txt = '', $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCantidadAlerta, $h = $hGlobal, $txt = '' , $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCostoUnitario, $h = $hGlobal, $txt = '', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCostoTotal, $h = $hGlobal, $txt = number_format($dataSource->getParameter('totalCosto'), 2), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Ln();
    }

}
?>