using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TDSAlmaxarifado.Models;

namespace TDSAlmaxarifado.Controllers
{
    public class AreaController : Controller
    {
        BDTDSAlmaxarifadoEntities bd = new BDTDSAlmaxarifadoEntities();
       // GET: Area
       [HttpGet]
        public ActionResult Index()
        {
            //var dados = bd.AREA.ToList();
            return View(bd.AREA.ToList());
        }

        [HttpGet]
        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(string descricao)
        {
            AREA novoArea = new AREA();
            novoArea.AREDESCRICAO = descricao;
            bd.AREA.Add(novoArea);
            try
            {
               bd.SaveChanges();
            }
            catch (Exception)
            {
               return RedirectToAction("ErrorBD", "Home");
            }

            return RedirectToAction("index");
        }

        [HttpGet]
        public ActionResult Editar(int id)
        {
            AREA exibirArea = bd.AREA.ToList().Where(y => y.AREID == id).First(); 
            return View(exibirArea);
        }

        public ActionResult Editar(int id,string descricao)
        {
            AREA updateArea = bd.AREA.ToList().Where(Y => Y.AREID == id).First();
            updateArea.AREDESCRICAO = descricao;
            bd.Entry(updateArea).State = EntityState.Modified;
            try
            {
                bd.SaveChanges();
            }
            catch (Exception)
            {
                return RedirectToAction("Error80", "Home");
            }
            return RedirectToAction("index");
        }

        [HttpPost]
        public ActionResult ExcluirConfirmar(int id)
        {
            AREA excluirArea = bd.AREA.ToList().Where(y => y.AREID == id).First();
            bd.AREA.Remove(excluirArea);
            try
            {
                bd.SaveChanges();
            }
            catch (Exception)
            {
                Mensagem.textoerro = "Não e possivel";
                return RedirectToAction("Error80", "Home");
            }
            return RedirectToAction("index");
        }

    }
}