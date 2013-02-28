<?php
require_once dirname(__FILE__) . '/pxpReport/Report.php';
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

        //$this->Image(dirname(__FILE__).'/logo-ypfb-logistica.png', 16, 12, 36);

        $this->SetFontSize(14);
        $this->SetFont('', 'B');
        $this->Cell(40, $midHeight, '', 'LRT', 0, 'C', false, '', 0, false, 'T', 'C');
        $this->Cell(105, $midHeight, strtoupper($this->dataSource->getParameter('tipo')).' VALORADO DE MATERIALES', 'LRT', 0, 'C', false, '', 0, false, 'T', 'C');

        $x = $this->GetX();
        $y = $this->GetY();
        $this->Ln();
        $this->Cell(40, $midHeight, '', 'LRB', 0, 'C', false, '', 0, false, 'T', 'C');
        $this->Cell(105, $midHeight, $this->dataSource->getParameter('almacen'), 'LRB', 0, 'C', false, '', 0, false, 'T', 'C');

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
        $this->Cell($width2, $height, $this->dataSource->getParameter('codigo'), "B", 0, 'C', false, '', 0, false, 'T', 'C');

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
        $this->Cell($width2, $height, $this->PageNo() . ' de ' . $this->getNumPages(), "B", 0, 'C', false, '', 0, false, 'T', 'C');
    }

    public function Footer() {
        //TODO: implement the footer manager
    }

}

Class RMovimiento extends Report {

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
        $pdf->SetMargins(PDF_MARGIN_LEFT, 40, PDF_MARGIN_RIGHT);
        $pdf->SetHeaderMargin(10);
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
        $hMedium = 7.5;
        $hLong = 15;
        
        $pdf->SetFontSize(7.5);
        $pdf->SetFont('', 'B');
        $pdf->Cell($w = 30, $h = $hMedium, $txt = 'MOTIVO: ', $border = 0, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->SetFont('', '');
        $pdf->Cell($w = 60, $h = $hMedium, $txt = $dataSource->getParameter('motivo'), $border = 0, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Ln();
        
        $pdf->SetFont('', 'B');
        $pdf->Cell($w = 30, $h = $hMedium, $txt = 'DESCRIPCION: ', $border = 0, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->SetFont('', '');
        $pdf->MultiCell($w = 0, $h = $hLong, $txt = $dataSource->getParameter('nombre'), $border = 0, $align = 'L', $fill = false, $ln = 1, $x = '', $y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);
        
        $pdf->SetFont('', 'B');
        $pdf->Cell($w = 30, $h = $hMedium, $txt = 'FECHA REMISION: ', $border = 0, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->SetFont('', '');
        $fechaRemision = new DateTime($dataSource->getParameter('fechaRemision'));
        $pdf->Cell($w = 60, $h = $hMedium, $txt = $fechaRemision->format('d/m/Y'), $border = 0, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Ln();
        
        $pdf->SetFont('', 'B');
        $pdf->Cell($w = 30, $h = $hMedium, $txt = 'FECHA '.strtoupper($dataSource->getParameter('tipo')).':', $border = 0, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->SetFont('', '');
        $fechaMovimiento = new DateTime($dataSource->getParameter('fechaMovimiento'));
        $pdf->Cell($w = 60, $h = $hMedium, $txt = $fechaMovimiento->format('d/m/Y'), $border = 0, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Ln();
        
        //Diseño de la tabla:
        $wNro = 10;
        $wCodigo = 15;
        $wDescripcionItem = 90;
        $wUnidad = 15;
        $wCantidad = 20;
        $wCostoUnitario = 15;
        $wCostoTotal = 20;
        
        $pdf->SetFontSize(6.5);
        $pdf->SetFont('', 'B');
        $pdf->Cell($w = $wNro, $h = $hGlobal, $txt = 'Nro.', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCodigo, $h = $hGlobal, $txt = 'Código', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wDescripcionItem, $h = $hGlobal, $txt = 'Descripcion del Material', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wUnidad, $h = $hGlobal, $txt = 'Unidad', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCantidad, $h = $hGlobal, $txt = 'Cantidad', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCostoUnitario, $h = $hGlobal, $txt = 'C/Unit.', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCostoTotal, $h = $hGlobal, $txt = 'C/Total', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Ln();
        
        $count = 1;
        foreach($dataSource->getDataset() as $datarow) {
            $pdf->SetFont('', '');
            $pdf->Cell($w = $wNro, $h = $hGlobal, $txt = $count, $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wCodigo, $h = $hGlobal, $txt = $datarow['codigo'], $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wDescripcionItem, $h = $hGlobal, $txt = $datarow['nombre'], $border = 1, $ln = 0, $align = 'L', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wUnidad, $h = $hGlobal, $txt = $datarow['unidad_medida'], $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wCantidad, $h = $hGlobal, $txt = number_format($datarow['cantidad'], 2), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wCostoUnitario, $h = $hGlobal, $txt = number_format($datarow['costo_unitario'], 2), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Cell($w = $wCostoTotal, $h = $hGlobal, $txt = number_format($datarow['costo_total'], 2), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
            $pdf->Ln();
            $count ++;
        }
        
        $pdf->SetFont('', 'B');
        $pdf->Cell($w = $wNro, $h = $hGlobal, $txt = '', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCodigo, $h = $hGlobal, $txt = '', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wDescripcionItem, $h = $hGlobal, $txt = 'Totales', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wUnidad, $h = $hGlobal, $txt = '', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCantidad, $h = $hGlobal, $txt = '', $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        //$pdf->Cell($w = $wCantidad, $h = $hGlobal, $txt = number_format($dataSource->getParameter('totalCantidad'), 2), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCostoUnitario, $h = $hGlobal, $txt = '', $border = 1, $ln = 0, $align = 'C', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Cell($w = $wCostoTotal, $h = $hGlobal, $txt = number_format($dataSource->getParameter('totalCosto'), 2), $border = 1, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->Ln();
        $pdf->Ln();
        $pdf->SetFont('', 'B');
        $pdf->Cell($w = 30, $h = $hMedium, $txt = 'OBSERVACIONES: ', $border = 0, $ln = 0, $align = 'R', $fill = false, $link = '', $stretch = 0, $ignore_min_height = false, $calign = 'T', $valign = 'M');
        $pdf->SetFont('', '');
        $pdf->MultiCell($w = 0, $h = $hLong, $txt = $dataSource->getParameter('observaciones'), $border = 0, $align = 'L', $fill = false, $ln = 1, $x = '', $y = '', $reseth = true, $stretch = 0, $ishtml = false, $autopadding = true, $maxh = $hMedium, $valign = 'M', $fitcell = false);

        $pdf->Output($fileName, 'F');
    }

}
?>