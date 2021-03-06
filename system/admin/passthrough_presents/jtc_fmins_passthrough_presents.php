<?php
/**
 *Funcionalidade: este arquivo é destinado ao formulário de repasse de brinde para vendedor.
 *Data de criação: 07/11/2016
 */
?>
<h1 id="title-page">Repasse de Brinde para Vendedor</h1>
<div class="big_form">
    <?php
        if(isset($_GET['msgid'])){
        ?>
            <span><?php echo messageRepository($_GET['msgid'], @$_GET['data'])?></span>
        <?php
        }
    ?>
    <form name="entry_inventory" method="POST" onsubmit="return validate_form()" action="?folder=passthrough_presents/&file=jtc_ins_passthrough_presents&ext=php">
        <button id="modal_list_button" type="button"  onclick="modal_list('seller')">Vendedor <i></i></button>
        <input id="modal_list_input" type="hidden" name="seller">
        <div class="date">
            <input id="checkbox_date" type="checkbox" name="date_use" id="checkbox_date" ><label for="checkbox_date">Usar Data e Hora atuais</label>
            <br>
            <input id="input_date" type="text" class="datepicker" name="date" maxlength="10" placeholder="Data">
            <input id="input_hour" type="text"  name="hour" maxlength="5" placeholder="Hora">

        </div>
        <h3>Produtos</h3>
        <table id="table_products">
            <thead>
            <tr>
                <th>Fabricante</th>
                <th>Código</th>
                <th>Modelo</th>
                <th>Sexo</th>
                <th>Tamanho</th>
                <th>Quantidade</th>
            </tr>
            </thead>
            <tbody>
                <tr class="line">
                    <td>
                        <select name="manufacturers[]" onchange="alt_code(this),alt_size_for_code(this)">
                            <option value="" hidden>Fabricante</option>
                            <?php
                            $sql_select_manufacturers = "SELECT id, name FROM manufacturers";
                            $sql_select_manufacturers_prepare = $dbconnection->prepare($sql_select_manufacturers);
                            $sql_select_manufacturers_prepare->execute();
                            while($sql_select_manufacturers_data = $sql_select_manufacturers_prepare->fetch()){
                                ?>
                                <option value="<?php echo $sql_select_manufacturers_data["id"];?>"><?php echo $sql_select_manufacturers_data["name"];?></option>
                                <?php
                            }
                            ?>
                        </select>
                    </td>
                    <td>
                        <select name="code[]" class="code" disabled="" onchange="alt_sex_model(this), alt_size(this)">
                            <option value="" hidden>Código</option>
                        </select>
                    </td>
                    <td class="model">
                        ---
                    </td>
                    <td class="sex">
                        ---
                    </td>
                    <td>
                        <select  disabled="" class="size" name="size[]" onchange="validate_quantity(this)">
                            <option value="" hidden>Tamanho</option>
                        </select>
                    </td>
                    <td>
                        <input type="text" class="quantity" name="quantity[]" onblur="validate_quantity(this)" placeholder="Quantidade">
                    </td>
                </tr>
            </tbody>
        </table>
        <div class="buttons">
            <button type="reset"><i class="fa fa-refresh" aria-hidden="true"></i></button>
            <button type="submit">Cadastrar</button>
        </div>
    </form>
</div>


